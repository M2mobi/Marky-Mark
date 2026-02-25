//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ListViewLayoutBlockBuilder: InlineAttributedStringViewLayoutBlockBuilder {

    // MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return UnorderedListMarkDownItem.self
    }

    override func build(
        _ markDownItem: MarkDownItem,
        asPartOfConverter converter: MarkDownConverter<UIView>,
        styling: ItemStyling,
        renderContext: RenderContext
    ) -> UIView {
        let listMarkDownItem = markDownItem as! ListMarkDownItem

        let listView = getListView(listMarkDownItem, styling: styling, renderContext: renderContext)

        let spacing: UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets
        return ContainerView(view: listView, spacing: spacing)
    }

    // MARK: Private

    /**
     Loops recursively through all listItems to create
     vertically appended list of ListItemView's

     - parameter listMarkDownItem: MarkDownItem to loop through
     - parameter styling:          Styling to apply to each list item

     - returns: A view containing all list items of given markDownItem
     */

    private func getListView(_ listMarkDownItem: ListMarkDownItem, styling: ItemStyling, renderContext: RenderContext) -> UIView {
        let listView = ListView(styling: styling)

        guard let listItems = listMarkDownItem.listItems else { return listView }

        for (itemIndex, listItem) in listItems.enumerated() {
            let bulletStyling = styling as? BulletStylingRule
            let listStyling = styling as? ListItemStylingRule

            let attributedString = attributedStringForMarkDownItem(
                listItem,
                styling: styling,
                renderContext: renderContext
            )

            let itemAccessibilityLabel = [
                attributedString.string,
                renderContext.accessibilityConfig?.listItemAccessibilityLabelPostfix?(itemIndex, listItems.count)
            ]
            .compactMap { $0 }
            .joined(separator: ", ")

            let listItemView = ListItemView(
                listMarkDownItem: listItem,
                styling: bulletStyling,
                attributedText: attributedString,
                renderContext: renderContext,
                accessibilityLabel: itemAccessibilityLabel
            )

            listItemView.bottomSpace = getScaledBottomSpace(
                listStyling: listStyling,
                renderContext: renderContext
            )

            listView.addSubview(listItemView)

            if let nestedListItems = listItem.listItems, nestedListItems.count > 0 {
                let nestedListView = getListView(
                    listItem,
                    styling: styling,
                    renderContext: renderContext
                )

                listView.addSubview(nestedListView)
            }
        }

        return listView
    }

    private func getScaledBottomSpace(
        listStyling: ListItemStylingRule?,
        renderContext: RenderContext
    ) -> CGFloat {
        let space = listStyling?.bottomListItemSpacing ?? 0

        let hasScalableFonts = renderContext.hasScalableFonts == true

        let scaleFactor = listStyling?.scaleFactor(hasScalableFonts: hasScalableFonts) ?? 1

        return space * scaleFactor
    }
}
