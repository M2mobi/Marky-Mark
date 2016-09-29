//
//  MarkdownToViewConverterConfiguration.swift
//  MarkyMark
//
//  Created by Menno Lovink on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

open class MarkdownToViewConverterConfiguration: MarkDownConverterConfiguration<UIView> {

    public override init(elementComposer: ElementComposer<UIView>, styling : Styling) {

        super.init(elementComposer: elementComposer, styling : styling)

        let converter = MarkDownConverter(configuration: MarkDownToInlineAttributedStringConverterConfiguration(styling : styling))

        addLayoutBlockBuilder(HeaderViewLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(ParagraphViewLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(ListViewLayoutBlockBuilder(converter:converter))
        addLayoutBlockBuilder(OrderedListViewLayoutBlockBuilder(converter:converter))
        addLayoutBlockBuilder(AlphabeticListViewLayoutBlockBuilder(converter:converter))
        addLayoutBlockBuilder(CodeViewLayoutBlockBuilder(converter:converter))
        addLayoutBlockBuilder(QuoteBlockLayoutBuilder(converter:converter))
        addLayoutBlockBuilder(HorizontalLineLayoutBlockBuilder())
        addLayoutBlockBuilder(ImageViewLayoutBlockBuilder())
    }

    public convenience init(styling : Styling){
        self.init(elementComposer: ViewAppenderComposer(), styling : styling)
    }
}
