//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

open class HeaderViewLayoutBlockBuilder: InlineAttributedStringViewLayoutBlockBuilder {

    // MARK: LayoutBuilder

    override open func relatedMarkDownItemType() -> MarkDownItem.Type {
        return HeaderMarkDownItem.self
    }

    override open func build(_ markDownItem: MarkDownItem, asPartOfConverter converter: MarkDownConverter<UIView>, styling: ItemStyling) -> UIView {
        let headerMarkDownItem = markDownItem as! HeaderMarkDownItem
        let headerStyling = styling as? HeadingStyling
        headerStyling?.configureForLevel(headerMarkDownItem.level)

        let label = AttributedInteractiveLabel()
        label.numberOfLines = 0
        label.markDownAttributedString = attributedStringForMarkDownItem(markDownItem, styling: headerStyling ?? styling)

        if let urlOpener = urlOpener {
            label.urlOpener = urlOpener
        }

        let spacing: UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets
        return ContainerView(view: label, spacing: spacing)
    }
}
