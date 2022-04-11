//
//  APIFetcher.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

///The file is reference from my own library https://github.com/phthphat-lib/pnetworking/
import Foundation

protocol APIFetcher {
    var baseUrl: String { get }
}

extension APIFetcher {
    private func generateRequest(from endPoint: EndPoint) throws -> URLRequest {
        let fullUrl = baseUrl + endPoint.path
        var urlComp = convertToUrlComponent(url: fullUrl)
        var request: URLRequest?
        
        switch endPoint.method {
        case .get:
            let queryItems = endPoint.param.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            urlComp?.queryItems = queryItems
            
            guard let urlToCall = urlComp?.url else {
                throw NetworkError.badUrl
            }
            request = URLRequest(url: urlToCall)
        default:
            
            guard let urlToCall = urlComp?.url else {
                throw NetworkError.badUrl
            }
            request = URLRequest(url: urlToCall)
            request?.httpBody = try? JSONSerialization.data(withJSONObject: endPoint.param, options: .prettyPrinted)
        }
        
        request?.httpMethod = endPoint.method.rawValue
        request?.allHTTPHeaderFields = endPoint.headers
        request?.addValue("Application/json", forHTTPHeaderField: "Content-type")
        return request!
    }
    
    public func requestNormalData(endPoint: EndPoint, handle: @escaping (Result<Data, NetworkError>) -> Void ){
        do {
            let request = try generateRequest(from: endPoint)
            makeRequest(request: request, endPoint: endPoint, handle: handle)
        } catch {
            guard let err = error as? NetworkError else {
                handle(.failure(.custom(msg: error.localizedDescription)))
                return
            }
            handle(.failure(err))
        }
    }
}

extension APIFetcher {
    private func convertToUrlComponent(url: String) -> URLComponents? {
        guard let url = URL(string: url) else { return nil }
        return URLComponents(url: url, resolvingAgainstBaseURL: true)
    }
        
    private func makeRequest(request: URLRequest, endPoint: EndPoint, handle: @escaping (Result<Data, NetworkError>) -> Void) {
        let session = URLSession.shared
        printApiLog(endPoint: endPoint, processAt: .requestStart)
        
        session.dataTask(with: request) { (_data, res, error) in
            self.printApiLog(endPoint: endPoint, processAt: .respondReceive)
            if let error = error {
                DispatchQueue.main.async {
                    handle(.failure(.network(msg: error.localizedDescription)))
                }
                self.printApiLog(endPoint: endPoint, processAt: .end)
                return
            }
            
            guard let data = _data else {
                handle(.failure(.network(msg: "No data response")))
                self.printApiLog(endPoint: endPoint, processAt: .end)
                return
            }
            
            DispatchQueue.main.async {
                self.printJsonData(data)
                handle(.success(data))
                self.printApiLog(endPoint: endPoint, processAt: .end)
            }
        }.resume()
    }
    
    private func printApiLog(endPoint: EndPoint, processAt: ProcessPosition) {
        switch processAt {
        case .requestStart:
            print("---- Request \(endPoint.method) on \(endPoint.path) ----")
            print("Header:", endPoint.headers ?? "empty")
            print("Param:", endPoint.param)
        case .respondReceive:
            print("---- Response \(endPoint.method) on \(endPoint.path) ----")
        case .errorOccur(let err):
            print("Error: ", err.localizedDescription)
        case .end:
            print("---- Finish request \(endPoint.method) on \(endPoint.path) ----")
        }
    }
    
    private func printJsonData(_ data: Data) {
        print("Json:", (try? JSONSerialization.jsonObject(with: data, options: [])) ?? "Unknown" )
    }
}


private enum ProcessPosition {
    case errorOccur(error: Error)
    case requestStart
    case respondReceive
    case end
}
