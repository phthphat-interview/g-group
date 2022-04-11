//
//  UIColor.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import UIKit

extension UIColor {
    static func equalRGB(_ number: CGFloat) -> UIColor {
        return .rgb(number, number, number)
    }
    ///In 255 base
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}
