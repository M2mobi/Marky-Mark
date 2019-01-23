//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public struct ListStyling: ItemStyling, BulletStylingRule, BaseFontStylingRule, ContentInsetStylingRule, ListItemStylingRule, TextColorStylingRule, LineHeightStylingRule {

    public var parent: ItemStyling?

    public func isApplicableOn(_ markDownItem: MarkDownItem) -> Bool {

        return markDownItem is ListMarkDownItem
    }

    public var bulletFont: UIFont? = .systemFont(ofSize: 14)
    public var bulletColor: UIColor? = .black
    public var bulletImage: UIImage?
    public var bulletImages: [UIImage?]?
    public var bulletViewSize: CGSize = CGSize(width: 16, height: 16)

    public var baseFont: UIFont? = UIFont.systemFont(ofSize: UIFont.systemFontSize)

    public var contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)

    public var bottomListItemSpacing: CGFloat = 5
    public var listIdentSpace: CGFloat = 15
    public var lineHeight: CGFloat?

    public var textColor: UIColor?

    public init() {}

}
