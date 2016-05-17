//
//  Created by Menno Lovink on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class HTMLStrikeThroughLayoutBlockBuilder: HTMLContainerLayoutBlockBuilder {

    // MARK: LayoutBlockBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return StrikeMarkDownItem.self
    }

    // MARK: HTMLContainerLayoutBlockBuilder

    override var htmlTag: String {
        return "del"
    }
}
