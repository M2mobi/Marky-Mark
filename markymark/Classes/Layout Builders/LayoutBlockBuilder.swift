//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

public class LayoutBlockBuilder<T> {

    /**
     - Builds a displayable object of type T. For example UIView or String
     - Uses information from type the MarkDownItem
     - Must be overwritten by a subclass

     - parameter markDownItem: Markdown item that needs display

     - returns: T
     */

    func build(markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<T>, styling : ItemStyling) -> T {
         fatalError("\(String(self)): Implement build")
    }

    /**
     Returns the kind of MarkDownItem the LayoutBlockBuilder supports

     - returns: Any MarkDownItem Class
     */
    
    func relatedMarkDownItemType() -> MarkDownItem.Type {
        fatalError("\(String(self)): Implement relatedMarkDownItemType")
    }
}