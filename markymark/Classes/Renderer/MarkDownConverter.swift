//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

public class MarkDownConverter<T> {

    let configuration:MarkDownConverterConfiguration<T>

    public init(configuration: MarkDownConverterConfiguration<T>) {
        self.configuration = configuration
    }


    /**
     Converts given MarkDownItems to type T
     Composes the converted items using the given elementComposer in the configuration
     
     - parameter markDownItems: markdownItems to convert
     
     - returns: type T containing all converted items composed together. Often a String or UIView
     */
    public func convert(markDownItems:[MarkDownItem]) -> T {

        return configuration.elementComposer.compose(convertToElements(markDownItems))
    }

    /**
     Coverts the MarkDownItem's into displayable objects of type T
     - T can be String or UIView for example
     - It uses `map` to find a LayoutBuilder for the given MarkdownItem

     - parameter markDownItems: Array of MarkdownItem created by the MarkDownParser
     ´
     - returns: An array of displayable objects of type T
     */
    func convertToElements(markDownItems:[MarkDownItem], applicableStyling: ItemStyling? = nil) -> [T] {

        var elements:[T] = []

        for markDownItem in markDownItems {

            let layoutBlockBuilder = self.configuration.layoutBlockBuilderForMarkDownItemType(markDownItem.dynamicType)

            var styling = self.configuration.styling.stylingForMarkownItem(markDownItem)
            styling.parent = applicableStyling

            if let layoutBlockBuilder = layoutBlockBuilder where markDownItem.dynamicType == layoutBlockBuilder.relatedMarkDownItemType() {
                let layoutItem = layoutBlockBuilder.build(markDownItem, asPartOfConverter: self, styling: styling)

                elements.append(layoutItem)
            } else {
                print("Can't find display item for \(String(markDownItem.self))")
            }
        }
        
        return elements;
    }
}
