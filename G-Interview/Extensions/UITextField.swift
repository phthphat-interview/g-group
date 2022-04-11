//
//  UITextField.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import UIKit


extension UITextField {
    convenience init(placeholder: String, font: UIFont = .systemFont(ofSize: 15)) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        self.font = font
    }
}
