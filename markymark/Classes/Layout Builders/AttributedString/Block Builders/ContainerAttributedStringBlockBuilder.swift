//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class ContainerAttributedStringBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString> {

    // MARK: LayoutBlockBuilder

    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<NSMutableAttributedString>, styling : ItemStyling?) -> NSMutableAttributedString {
        let string = NSMutableAttributedString()

        if let markDownItems = markDownItem.markDownItems {

            for subString in converter.convertToElements(markDownItems, applicableStyling: styling) {

                string.append(subString)
            }
        }

        return string
    }
}
