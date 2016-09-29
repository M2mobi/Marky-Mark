//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public struct DefaultStyling: Styling {

    fileprivate var extraStyling: [ItemStyling] = []

    public var paragraphStyling = ParagraphStyling()
    public var italicStyling = ItalicStyling()
    public var boldStyling = BoldStyling()
    public var headingStyling = HeadingStyling()
    public var strikeThroughStyling = StrikeThroughStyling()
    public var listStyling = ListStyling()
    public var imageStyling = ImageStyling()
    public var linkStyling = LinkStyling()
    public var horizontalLineStyling = HorizontalLineStyling()
    public var codeBlockStyling = CodeBlockStyling()
    public let inlineCodeBlockStyling = InlineCodeStyling()
    public let quoteStyling = QuoteStyling()

    public mutating func addStyling(_ styling:ItemStyling) {
        extraStyling.append(styling)
    }

    public var itemStylingRules: [ItemStyling] {
        return extraStyling + collectStylingRules()
    }

    public init(){}
}
