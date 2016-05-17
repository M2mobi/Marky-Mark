//
// Created by Jim van Zummeren on 28/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

class MarkDownHTMLConverterConfiguration : MarkDownConverterConfiguration<String> {

    override init(elementComposer: ElementComposer<String>, styling : Styling) {

        super.init(elementComposer: elementComposer, styling: styling)

        addLayoutBlockBuilder(HTMLHeaderLayoutBlockBuilder())
        addLayoutBlockBuilder(HTMLParagraphLayoutBlockBuilder())
        addLayoutBlockBuilder(HTMLBoldLayoutBlockBuilder())
        addLayoutBlockBuilder(HTMLInlineTextLayoutBlockBuilder())
        addLayoutBlockBuilder(HTMLStrikeThroughLayoutBlockBuilder())
        addLayoutBlockBuilder(HTMLItalicLayoutBlockBuilder())

    }

    convenience init(styling : Styling){
        self.init(elementComposer: StringComposer(), styling: styling)
    }
}
