//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public protocol BulletStylingRule : ItemStyling {

    /// Font to use for the bullet
    var bulletFont : UIFont? { get }
    /// Color to use for the bullet
    var bulletColor : UIColor? { get }
    /// Optional image as bullet instead of a font
    var bulletImage : UIImage? { get }
    /// Array of bullet images, each item in the array is used for deeper level nesting
    var bulletImages : [UIImage?]? { get }
    /// Size of the view used for the bullet
    var bulletViewSize : CGSize { get }
}

extension BulletStylingRule {

    public var bulletImage : UIImage? { return nil }

    public var bulletImages: [UIImage]? {
        if let bulletImage = bulletImage {
            return [bulletImage]
        } else {
            return []
        }
    }
}
