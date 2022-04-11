//
//  Missable.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//
import Foundation
///reference to my own package: https://github.com/phthphat-lib/swift-utility/tree/main/Sources/SwiftUtility/CodableHelper
//PropertyWrapper (treasure of Swift 5)
@propertyWrapper
///the properties wrapper prevent throwing error when server response wrong type, or null, or undefined. If it does, it will use `defaultDecodeValue` of `DefaultDecodable` you provide
public struct Missable<T>: CustomStringConvertible {
    
    public var wrappedValue: T
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    public var description: String {
        return String(describing: wrappedValue)
    }
}

extension Missable: Decodable where T: DefaultDecodable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            wrappedValue = try container.decode(T.self)
        } catch {
            print(error.localizedDescription)
            wrappedValue =  .defaultDecodeValue
        }
    }
}

extension Missable: Encodable where T: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let optionalWrapVal = wrappedValue as Optional<T>
        switch optionalWrapVal {
        case .some(let value): try container.encode(value)
        case .none: try container.encodeNil()
        }
    }
}
extension Missable: Equatable where T: Equatable {}
extension Missable: Hashable where T: Hashable {}

extension KeyedDecodingContainer {
    public func decode<T: DefaultDecodable>(_ type: Missable<T>.Type,
                             forKey key: Key) throws -> Missable<T> {
        return try decodeIfPresent(type, forKey: key) ?? .init(wrappedValue: .defaultDecodeValue)
    }
}
