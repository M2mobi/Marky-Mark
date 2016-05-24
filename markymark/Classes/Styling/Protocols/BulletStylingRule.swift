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
    /// Size of the view used for the bullet
    var bulletViewSize : CGSize { get }

}

extension BulletStylingRule {
    public var bulletViewSize : CGSize {
        return CGSize(width: 10, height: 16)
    }
}