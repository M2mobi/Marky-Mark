//
//  MarkDownToAttributedStringConverterConfiguration.swift
//  MarkyMark
//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class MarkDownToInlineAttributedStringConverterConfiguration: MarkDownConverterConfiguration<NSMutableAttributedString> {

    override init(elementComposer: ElementComposer<NSMutableAttributedString>, styling : Styling) {
        super.init(elementComposer: elementComposer, styling : styling)
        addLayoutBlockBuilder(InlineTextAttributedStringBlockBuilder())
        addLayoutBlockBuilder(BoldAttributedStringBlockBuilder())
        addLayoutBlockBuilder(StrikeThroughAttributedStringBlockBuilder())
        addLayoutBlockBuilder(ItalicAttributedStringBlockBuilder())
        addLayoutBlockBuilder(InlineImageAttributedStringBlockBuilder())
        addLayoutBlockBuilder(LinkViewLayoutBlockBuilder())
        addLayoutBlockBuilder(InlineCodeAttributedStringBlockBuilder())
    }

    convenience init(styling : Styling){
        self.init(elementComposer: InlineAttributedStringComposer(), styling: styling)
    }
}
