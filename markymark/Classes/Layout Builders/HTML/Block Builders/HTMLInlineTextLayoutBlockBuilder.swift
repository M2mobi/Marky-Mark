//
//  Created by Menno Lovink on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class HTMLInlineTextLayoutBlockBuilder: LayoutBlockBuilder<String> {
    
    // MARK: LayoutBlockBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return InlineTextMarkDownItem.self
    }

    override func build(markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<String>, styling : ItemStyling?) -> String {
        return markDownItem.content
    }
}
