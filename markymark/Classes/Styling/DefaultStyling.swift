//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

open class DefaultStyling: Styling {

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
    public var inlineCodeBlockStyling = InlineCodeStyling()
    public var quoteStyling = QuoteStyling()

    private var defaultStyling: [ItemStyling] {
        return [
            paragraphStyling,
            italicStyling,
            boldStyling,
            headingStyling,
            strikeThroughStyling,
            listStyling,
            imageStyling,
            linkStyling,
            horizontalLineStyling,
            codeBlockStyling,
            inlineCodeBlockStyling,
            quoteStyling
        ]
    }

    public func addStyling(_ styling:ItemStyling) {
        extraStyling.append(styling)
    }

    public var itemStylingRules: [ItemStyling] {
        return extraStyling + defaultStyling
    }

    public init(){}
}
