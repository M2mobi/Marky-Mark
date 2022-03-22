//
//  MarkdownToViewConverterConfiguration.swift
//  MarkyMark
//
//  Created by Menno Lovink on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

open class MarkdownToViewConverterConfiguration: MarkDownConverterConfiguration<UIView> {

    public var urlOpener: URLOpener? {
        didSet {
            markDownItemToLayoutBuilderMap.values.forEach(setUrlOpenerIfPossible)
        }
    }

    private let inlineConverter: MarkDownConverterConfiguration<NSMutableAttributedString>

    public init(elementComposer: ElementComposer<UIView>, styling: Styling, urlOpener: URLOpener? = nil) {
        self.urlOpener = urlOpener

        inlineConverter = MarkDownToInlineAttributedStringConverterConfiguration(styling: styling)
        super.init(elementComposer: elementComposer, styling: styling)

        let converter = MarkDownConverter(configuration: inlineConverter)

        addLayoutBlockBuilder(HeaderViewLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(ParagraphViewLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(ListViewLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(OrderedListViewLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(AlphabeticListViewLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(CodeViewLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(QuoteBlockLayoutBuilder(converter: converter))
        addLayoutBlockBuilder(HorizontalLineLayoutBlockBuilder())
        addLayoutBlockBuilder(ImageViewLayoutBlockBuilder())
    }

    public convenience init(styling: Styling, urlOpener: URLOpener? = nil) {
        self.init(elementComposer: ViewAppenderComposer(), styling: styling, urlOpener: urlOpener)
    }

    override open func addLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<UIView>) {
        super.addLayoutBlockBuilder(layoutBlockBuilder)
        setUrlOpenerIfPossible(layoutBlockBuilder)
    }

    open func addInlineLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString>) {
        inlineConverter.addLayoutBlockBuilder(layoutBlockBuilder)
    }
}

private extension MarkdownToViewConverterConfiguration {

    func setUrlOpenerIfPossible(_ layoutBlockBuilder: LayoutBlockBuilder<UIView>) {
        (layoutBlockBuilder as? CanSetURLOpener)?.set(urlOpener: urlOpener)
    }
}
