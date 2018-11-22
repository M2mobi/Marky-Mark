//
//  MarkdownToViewConverterConfiguration.swift
//  MarkyMark
//
//  Created by Menno Lovink on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

open class MarkdownToViewConverterConfiguration: MarkDownConverterConfiguration<UIView> {

    public init(elementComposer: ElementComposer<UIView>, styling: Styling, urlOpener: URLOpener? = nil) {

        super.init(elementComposer: elementComposer, styling: styling)

        let converter = MarkDownConverter(configuration: MarkDownToInlineAttributedStringConverterConfiguration(styling: styling))

        addLayoutBlockBuilder(HeaderViewLayoutBlockBuilder(converter: converter, urlOpener: urlOpener))
        addLayoutBlockBuilder(ParagraphViewLayoutBlockBuilder(converter: converter, urlOpener: urlOpener))
        addLayoutBlockBuilder(ListViewLayoutBlockBuilder(converter: converter, urlOpener: urlOpener))
        addLayoutBlockBuilder(OrderedListViewLayoutBlockBuilder(converter: converter, urlOpener: urlOpener))
        addLayoutBlockBuilder(AlphabeticListViewLayoutBlockBuilder(converter: converter, urlOpener: urlOpener))
        addLayoutBlockBuilder(CodeViewLayoutBlockBuilder(converter: converter, urlOpener: urlOpener))
        addLayoutBlockBuilder(QuoteBlockLayoutBuilder(converter: converter, urlOpener: urlOpener))
        addLayoutBlockBuilder(HorizontalLineLayoutBlockBuilder())
        addLayoutBlockBuilder(ImageViewLayoutBlockBuilder())
    }

    public convenience init(styling: Styling, urlOpener: URLOpener? = nil) {
        self.init(elementComposer: ViewAppenderComposer(), styling: styling, urlOpener: urlOpener)
    }
}
