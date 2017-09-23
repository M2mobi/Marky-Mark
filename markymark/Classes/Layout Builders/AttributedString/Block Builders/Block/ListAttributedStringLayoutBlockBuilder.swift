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
    
    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<NSMutableAttributedString>, styling : ItemStyling) -> NSMutableAttributedString {
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
    
    func getListAttributedString(_ listMarkDownItem:ListMarkDownItem, styling:ItemStyling, level:CGFloat = 0) -> NSMutableAttributedString {
        
        let listAttributedString = NSMutableAttributedString()
                
        for listItem in listMarkDownItem.listItems ?? [] {
            
            let bulletStyling = styling as? BulletStylingRule
            let listStyling = styling as? ListItemStylingRule
            
            let listItemAttributedString = NSMutableAttributedString()
            listItemAttributedString.append(getBulletCharacter(listItem, styling: bulletStyling))
            listItemAttributedString.addAttributes(
                getBulletIndentingAttributesForLevel(level, listStyling: listStyling),
                range: listItemAttributedString.fullRange()
            )
            
            let attributedString = attributedStringForMarkDownItem(listItem, styling: styling)
            listItemAttributedString.append(attributedString)
            listItemAttributedString.append(NSAttributedString(string:"\n"))
            listAttributedString.append(listItemAttributedString)

            if let nestedListItems = listItem.listItems, nestedListItems.count > 0 {
                listAttributedString.append(getListAttributedString(listItem, styling: styling, level: level + 1))
            }
        }
        
        return listAttributedString
    }
    
    func getBulletCharacter(_ listMarkDownItem:ListMarkDownItem, styling:BulletStylingRule?) -> NSAttributedString {
        
        let string:String
        
        if let indexCharacter = listMarkDownItem.indexCharacter {
            string = indexCharacter + " "
        } else {
            string = "• "
        }
        
        return NSMutableAttributedString(string:string, attributes: getBulletStylingAttributes(styling))
    }
    
    func getBulletStylingAttributes(_ styling:BulletStylingRule?) -> [NSAttributedStringKey : Any] {
        var attributes = [NSAttributedStringKey : Any]()
        
        if let font = styling?.bulletFont {
            attributes[.font] = font
        }
        
        if let textColor = styling?.bulletColor {
            attributes[.foregroundColor] = textColor
        }
        
        return attributes
    }
    
    func getBulletIndentingAttributesForLevel(_ level:CGFloat, listStyling: ListItemStylingRule?) -> [NSAttributedStringKey : Any] {
        let listIndentSpace = (listStyling?.listIdentSpace ?? 0)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = (listStyling?.bottomListItemSpacing ?? 0)
        paragraphStyle.firstLineHeadIndent = listIndentSpace * level
        paragraphStyle.headIndent = listIndentSpace + listIndentSpace * level
        
        return [.paragraphStyle : paragraphStyle]
    }
}
