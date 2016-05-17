//
//  Created by Jim van Zummeren on 10/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class InlineCodeAttributedStringBlockBuilder: ContainerAttributedStringBlockBuilder {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return InlineCodeMarkDownItem.self
    }
}