//
//  Created by Jim van Zummeren on 11/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class OrderedListViewLayoutBlockBuilder : ListViewLayoutBlockBuilder {

    //MARK: LayoutBuilder
    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return OrderedListMarkDownItem.self
    }
}