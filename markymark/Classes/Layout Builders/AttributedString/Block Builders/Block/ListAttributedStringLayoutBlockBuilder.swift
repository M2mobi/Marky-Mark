//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ListAttributedStringLayoutBlockBuilder: InlineAttributedStringLayoutBlockBuilder {
    
    //MARK: LayoutBuilder
    
    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return UnorderedListMarkDownItem.self
    }
    
    override func build(markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<NSMutableAttributedString>, styling : ItemStyling) -> NSMutableAttributedString {
        let listMarkDownItem = markDownItem as! ListMarkDownItem
        
        let listAttributedString = getListAttributedString(listMarkDownItem, styling: styling)
        
        return listAttributedString
    }
    
    //MARK: Private
}

private extension ListAttributedStringLayoutBlockBuilder {
    

    /**
     Loops recursively through all listItems to create
     vertically appended list of ListItemView's
     
     - parameter listMarkDownItem: MarkDownItem to loop through
     - parameter styling:          Styling to apply to each list item
     
     - returns: A view containing all list items of given markDownItem
     */
    
    func getListAttributedString(listMarkDownItem:ListMarkDownItem, styling:ItemStyling, level:CGFloat = 0) -> NSMutableAttributedString {
        
        let listAttributedString = NSMutableAttributedString()
        
        let listView = ListView(styling:styling)
        
        for listItem in listMarkDownItem.listItems ?? [] {
            
            let bulletStyling = styling as? BulletStylingRule
            let listStyling = styling as? ListItemStylingRule
            
            let listItemAttributedString = NSMutableAttributedString()
            listItemAttributedString.appendAttributedString(getBulletCharacter(listItem, styling: bulletStyling))
            listItemAttributedString.addAttributes(
                getBulletIndentingAttributesForLevel(level, listStyling: listStyling),
                range: listItemAttributedString.fullRange()
            )
            
            let attributedString = attributedStringForMarkDownItem(listItem, styling: styling)
            listItemAttributedString.appendAttributedString(attributedString)
            listItemAttributedString.appendAttributedString(NSAttributedString(string:"\n"))
            listAttributedString.appendAttributedString(listItemAttributedString)

            if let nestedListItems = listItem.listItems where nestedListItems.count > 0 {
                listAttributedString.appendAttributedString(getListAttributedString(listItem, styling: styling, level: level + 1))
            }
        }
        
        return listAttributedString
    }
    
    func getBulletCharacter(listMarkDownItem:ListMarkDownItem, styling:BulletStylingRule?) -> NSAttributedString {
        
        let string:String
        
        if let indexCharacter = listMarkDownItem.indexCharacter {
            string = indexCharacter + " "
        } else {
            string = "• "
        }
        
        return NSMutableAttributedString(string:string, attributes: getBulletStylingAttributes(styling))
    }
    
    func getBulletStylingAttributes(styling:BulletStylingRule?) -> [String : AnyObject] {
        var attributes = [String : AnyObject]()
        
        if let font = styling?.bulletFont {
            attributes[NSFontAttributeName] = font
        }
        
        if let textColor = styling?.bulletColor {
            attributes[NSForegroundColorAttributeName] = textColor
        }
        
        return attributes
    }
    
    func getBulletIndentingAttributesForLevel(level:CGFloat, listStyling: ListItemStylingRule?) -> [String : AnyObject] {
        let listIndentSpace = (listStyling?.listIdentSpace ?? 0)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = (listStyling?.bottomListItemSpacing ?? 0)
        paragraphStyle.firstLineHeadIndent = listIndentSpace * level
        paragraphStyle.headIndent = listIndentSpace + listIndentSpace * level
        
        return [NSParagraphStyleAttributeName : paragraphStyle]
    }
}
