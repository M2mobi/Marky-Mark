//
//  AttributedLabelStyling.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation

open class AttributedLabelStyling: Styling {

    public var paragraphStyling = ParagraphStyling()
    public var italicStyling = ItalicStyling()
    public var boldStyling = BoldStyling()
    public var linkStyling = LinkStyling()
    public var strikeThroughStyling = StrikeThroughStyling()

    public var itemStylingRules: [ItemStyling] {
        return [paragraphStyling, italicStyling, boldStyling, linkStyling, strikeThroughStyling]
    }
}
