//
//  UIButton.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import UIKit
extension UIButton {
    
    convenience public init(type: ButtonType = .system, title: String, titleColor: UIColor, font: UIFont = .systemFont(ofSize: 14), backgroundColor: UIColor = .clear) {
        self.init(type: type)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
    }
    
    convenience public init(type: ButtonType = .system, image: UIImage, tintColor: UIColor? = nil) {
        self.init(type: type)
        if tintColor == nil {
            setImage(image, for: .normal)
        } else {
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = tintColor
        }
    }
}
