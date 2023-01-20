//
//  UIFont+scaledFont.swift
//  Pods
//
//  Created by Jim van Zummeren on 19/01/2023.
//

import UIKit

extension UIFont {

    func scaledFont(textStyle: UIFont.TextStyle, maximumPointSize: CGFloat? = nil) -> UIFont {
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)

        if let maximumPointSize = maximumPointSize {
            return fontMetrics.scaledFont(
                for: self,
                maximumPointSize: maximumPointSize
            )
        } else {
            return fontMetrics.scaledFont(for: self)
        }
    }
}
