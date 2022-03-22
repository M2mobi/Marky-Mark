//
//  MarkDownToAttributedStringConverterConfiguration.swift
//  Pods
//
//  Created by Jim van Zummeren on 11/06/16.
//
//

import Foundation
import UIKit

open class MarkDownToAttributedStringConverterConfiguration: MarkDownConverterConfiguration<NSMutableAttributedString> {

    private let inlineConverter: MarkDownConverterConfiguration<NSMutableAttributedString>

    public override init(elementComposer: ElementComposer<NSMutableAttributedString>, styling: Styling) {
        inlineConverter = MarkDownToInlineAttributedStringConverterConfiguration(styling: styling)
        super.init(elementComposer: elementComposer, styling: styling)


        let converter = MarkDownConverter(configuration: inlineConverter)

        addLayoutBlockBuilder(HeaderAttributedStringLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(ParagraphAttributedStringLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(ListAttributedStringLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(OrderedListAttributedStringLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(AlphabeticListAttributedStringLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(CodeAttributedStringLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(QuoteAttributedStringLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(ImageAttributedStringBlockBuilder())
    }

    public convenience init(styling: Styling) {
        self.init(elementComposer: AttributedStringComposer(), styling: styling)
    }

    open func addInlineLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString>) {
        inlineConverter.addLayoutBlockBuilder(layoutBlockBuilder)
    }
}
