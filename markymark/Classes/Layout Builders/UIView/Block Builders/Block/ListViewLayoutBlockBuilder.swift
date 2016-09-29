//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ListViewLayoutBlockBuilder : InlineAttributedStringViewLayoutBlockBuilder {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return UnorderedListMarkDownItem.self
    }

    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<UIView>, styling : ItemStyling) -> UIView {
        let listMarkDownItem = markDownItem as! ListMarkDownItem

        let listView = getListView(listMarkDownItem, styling: styling)

        let spacing:UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets
        return ContainerView(view: listView, spacing: spacing)
    }

    //MARK: Private
    
    /**
     Loops recursively through all listItems to create
     vertically appended list of ListItemView's
     
     - parameter listMarkDownItem: MarkDownItem to loop through
     - parameter styling:          Styling to apply to each list item
     
     - returns: A view containing all list items of given markDownItem
     */
    
    fileprivate func getListView(_ listMarkDownItem:ListMarkDownItem, styling:ItemStyling) -> UIView {

        let listView = ListView(styling:styling)

        for listItem in listMarkDownItem.listItems ?? [] {

            let bulletStyling = styling as? BulletStylingRule
            let listStyling = styling as? ListItemStylingRule

            let attributedString  = attributedStringForMarkDownItem(listItem, styling: styling)
            let listItemView = ListItemView(listMarkDownItem: listItem, styling: bulletStyling, attributedText : attributedString)

            listItemView.bottomSpace = (listStyling?.bottomListItemSpacing ?? 0)

            listView.addSubview(listItemView)

            if let nestedListItems = listItem.listItems , nestedListItems.count > 0 {
                let nestedListView = getListView(listItem, styling: styling)
                listView.addSubview(nestedListView)

            }

        }

        return listView
    }
    
}
