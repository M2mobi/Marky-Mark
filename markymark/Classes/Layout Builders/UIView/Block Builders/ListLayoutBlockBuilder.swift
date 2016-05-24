//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ListLayoutBlockBuilder : AttributedStringViewLayoutBlockBuilder {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return UnorderedListMarkDownItem.self
    }

    override func build(markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<UIView>, styling : ItemStyling) -> UIView {
        let listMarkDownItem = markDownItem as! ListMarkDownItem
        let spacing:UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets

        return getListView(listMarkDownItem, styling: styling, spacing:spacing)
    }

    //MARK: Private
    
    /**
     Loops recursively through all listItems to create
     vertically appended list of ListItemView's
     
     - parameter listMarkDownItem: MarkDownItem to loop through
     - parameter styling:          Styling to apply to each list item
     
     - returns: A view containing all list items of given markDownItem
     */
    
    private func getListView(listMarkDownItem:ListMarkDownItem, styling:ItemStyling, spacing:UIEdgeInsets? = nil) -> UIView {

        let listView = UIView()

        let viewAppender = AutoLayoutViewAppender(container: listView)

        for listItem in listMarkDownItem.listItems ?? [] {

            let bulletStyling = styling as? BulletStylingRule
            let listStyling = styling as? ListItemStylingRule

            let label = ListItemView(listMarkDownItem: listItem, styling: bulletStyling, spacing: spacing)
            label.attributedText = attributedStringForMarkDownItem(listItem, styling: styling)

            viewAppender.appendView(label, verticalMargin: listStyling?.bottomListItemSpacing ?? 0, horizontalMargin: 0)

            if let nestedListItems = listItem.listItems where nestedListItems.count > 0 {
                let listView = getListView(listItem, styling: styling)
                viewAppender.appendView(listView, verticalMargin: 0, horizontalMargin: listStyling?.listIdentSpace ?? 10)
            }
        }

        viewAppender.finishAppendingWithPadding(0)

        return listView
    }
}