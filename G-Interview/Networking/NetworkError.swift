//
//  NetworkError.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import Foundation

public enum NetworkError: Error {
    case badUrl
    case network(msg: String)
    case custom(msg: String)
    
    var message: String {
        switch self {
        case .badUrl:
            return "Bad or invalid url"
        case .custom(let msg), .network(let msg):
            return msg
        }
    }
}
