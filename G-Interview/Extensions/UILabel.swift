//
//  UILabel.swift
//  G-Interview
//
//  Created by Phat Pham on 11/04/2022.
//

import UIKit

extension UILabel {
    convenience public init(text: String = "", font: UIFont? = .systemFont(ofSize: 13), textColor: UIColor = .black, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 0) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    convenience public init(
        attrText: NSAttributedString = .init(string: ""),
        font: UIFont? = .systemFont(ofSize: 13),
        textColor: UIColor = .black,
        textAlignment: NSTextAlignment = .left, numberOfLines: Int = 0
    ) {
        self.init()
        self.textColor = textColor
        self.font = font
        self.attributedText = attrText
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
