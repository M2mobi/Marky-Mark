//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class InlineTextAttributedStringBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString> {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return InlineTextMarkDownItem.self
    }

    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<NSMutableAttributedString>, styling : ItemStyling) -> NSMutableAttributedString {

        return NSMutableAttributedString(string: markDownItem.content, attributes: StringAttributesBuilder().attributesForStyling(styling))
    }
}
