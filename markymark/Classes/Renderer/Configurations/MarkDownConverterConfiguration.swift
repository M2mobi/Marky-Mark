//
// Created by Jim van Zummeren on 28/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

public class MarkDownConverterConfiguration<T> {

    /// Dictionary that contains the connection between MarkDownItems and LayoutBlockBuilder's
    var markDownItemToLayoutBuilderMap: [String:LayoutBlockBuilder<T>] = [:]
    
    /// Any kind of element composer that can combine converted MarkDownItem's
    let elementComposer : ElementComposer<T>
    
    /// Styling to use
    let styling : Styling

    public init(elementComposer : ElementComposer<T>, styling : Styling) {

        self.elementComposer = elementComposer
        self.styling = styling
    }

    func layoutBlockBuilderForMarkDownItemType(markDownItemType: MarkDownItem.Type) -> LayoutBlockBuilder<T>? {
        return markDownItemToLayoutBuilderMap[String(markDownItemType)]
    }

    func addLayoutBlockBuilder(layoutBlockBuilder: LayoutBlockBuilder<T>) {
        markDownItemToLayoutBuilderMap[String(layoutBlockBuilder.relatedMarkDownItemType())] = layoutBlockBuilder
    }
}