//
//  File.swift
//  
//
//  Created by Phat Pham on 03/07/2021.
//

import Foundation

public protocol DefaultDecodable: Decodable {
    static var defaultDecodeValue: Self { get }
}

extension Int: DefaultDecodable {
    public static var defaultDecodeValue: Int = 0
}
extension Bool: DefaultDecodable {
    public static var defaultDecodeValue: Bool = false
}
extension String: DefaultDecodable {
    public static var defaultDecodeValue: String = ""
}
extension Float: DefaultDecodable {
    public static var defaultDecodeValue: Float = 0
}
extension Double: DefaultDecodable {
    public static var defaultDecodeValue: Double = 0
}
extension UInt64: DefaultDecodable {
    public static var defaultDecodeValue: UInt64 = 0
}
extension Array: DefaultDecodable where Element: Decodable {
    public static var defaultDecodeValue: Array<Element> {
        return []
    }
}
extension Set: DefaultDecodable where Element: Decodable {
    public static var defaultDecodeValue: Set<Element> {
        return .init()
    }
}
extension Optional: DefaultDecodable where Wrapped: Decodable {
    public static var defaultDecodeValue: Optional<Wrapped> {
        return nil
    }
}
