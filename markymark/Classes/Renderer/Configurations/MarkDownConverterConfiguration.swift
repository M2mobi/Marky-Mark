//
// Created by Jim van Zummeren on 28/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

open class MarkDownConverterConfiguration<T> {

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

    func layoutBlockBuilderForMarkDownItemType(_ markDownItemType: MarkDownItem.Type) -> LayoutBlockBuilder<T>? {
        return markDownItemToLayoutBuilderMap[String(describing: markDownItemType)]
    }

    open func addLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<T>) {
        markDownItemToLayoutBuilderMap[String(describing: layoutBlockBuilder.relatedMarkDownItemType())] = layoutBlockBuilder
    }
}
