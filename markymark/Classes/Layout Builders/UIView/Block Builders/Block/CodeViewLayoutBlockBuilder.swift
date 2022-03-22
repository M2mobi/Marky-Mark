//
//  Created by Jim van Zummeren on 10/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

open class CodeViewLayoutBlockBuilder: InlineAttributedStringViewLayoutBlockBuilder {

    // MARK: LayoutBuilder

    override open func relatedMarkDownItemType() -> MarkDownItem.Type {
        return CodeBlockMarkDownItem.self
    }

    override open func build(_ markDownItem: MarkDownItem, asPartOfConverter converter: MarkDownConverter<UIView>, styling: ItemStyling) -> UIView {
        let codeBlockMarkDownItem = markDownItem as! CodeBlockMarkDownItem

        let label = AttributedInteractiveLabel()
        label.numberOfLines = 0
        label.text = codeBlockMarkDownItem.content
        label.font = (styling as? BaseFontStylingRule)?.baseFont
        label.textColor = (styling as? TextColorStylingRule)?.textColor

        if let urlOpener = urlOpener {
            label.urlOpener = urlOpener
        }

        let spacing: UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets

        let containerView = ContainerView(view: label, spacing: spacing)
        containerView.backgroundColor = (styling as? BackgroundStylingRule)?.backgroundColor

        return containerView
    }
}
