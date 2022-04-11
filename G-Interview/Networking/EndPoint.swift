//
//  EndPoint.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import Foundation

struct EndPoint {
    var path:String
    var method: HTTPMethod
    var param: [String: Any]
    var headers: [String: String] = [:]
}

enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}
