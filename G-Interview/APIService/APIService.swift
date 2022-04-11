//
//  APIService.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import Foundation

typealias HandleAPIModel<T: Decodable> = (Result<T, NetworkError>) -> Void

protocol APIService: APIFetcher {}

extension APIService {
    public func request<T: Decodable>(_ endpoint: EndPoint, handler: @escaping HandleAPIModel<T>) {
        self.requestNormalData(endPoint: endpoint) { result in
            switch result {
            case .success(let data):
                DispatchQueue.global(qos: .utility).async {
                    do {
                        let model = try JSONDecoder().decode(APIResponse<T>.self, from: data)
                        DispatchQueue.main.async {
                            handler(.success(model.data))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            handler(.failure(.custom(msg: error.localizedDescription)))
                        }
                    }
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    handler(.failure(err))
                }
            }
        }
    }
}

struct APIResponse<T: Decodable>: Decodable {
    var data: T
}
