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
    
    public override init(elementComposer: ElementComposer<NSMutableAttributedString>, styling : Styling) {
        
        super.init(elementComposer: elementComposer, styling : styling)
        
        let converter = MarkDownConverter(configuration: MarkDownToInlineAttributedStringConverterConfiguration(styling : styling))
        
        addLayoutBlockBuilder(HeaderAttributedStringLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(ParagraphAttributedStringLayoutBlockBuilder(converter: converter))
        addLayoutBlockBuilder(ListAttributedStringLayoutBlockBuilder(converter:converter))
        addLayoutBlockBuilder(OrderedListAttributedStringLayoutBlockBuilder(converter:converter))
        addLayoutBlockBuilder(AlphabeticListAttributedStringLayoutBlockBuilder(converter:converter))
        addLayoutBlockBuilder(CodeAttributedStringLayoutBlockBuilder(converter:converter))
        addLayoutBlockBuilder(QuoteAttributedStringLayoutBlockBuilder(converter:converter))
        addLayoutBlockBuilder(ImageAttributedStringBlockBuilder())
    }
    
    public convenience init(styling : Styling){
        self.init(elementComposer: AttributedStringComposer(), styling : styling)
    }
}
