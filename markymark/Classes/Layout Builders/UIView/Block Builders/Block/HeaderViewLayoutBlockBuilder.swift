//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class HeaderViewLayoutBlockBuilder: InlineAttributedStringViewLayoutBlockBuilder {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return HeaderMarkDownItem.self
    }

    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<UIView>, styling : ItemStyling) -> UIView {
        let headerMarkDownItem = markDownItem as! HeaderMarkDownItem
        let headerStyling = styling as? HeadingStyling
        headerStyling?.configureForLevel(headerMarkDownItem.level)
        
        let label = AttributedInteractiveLabel()
        label.numberOfLines = 0
        label.markDownAttributedString = attributedStringForMarkDownItem(markDownItem, styling: headerStyling ?? styling)

        let spacing: UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets
        return ContainerView(view: label, spacing: spacing)
    }
}
