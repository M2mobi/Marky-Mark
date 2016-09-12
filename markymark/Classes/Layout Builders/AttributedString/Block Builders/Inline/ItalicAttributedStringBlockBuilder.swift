//
//  Created by Menno Lovink on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class ItalicAttributedStringBlockBuilder: ContainerAttributedStringBlockBuilder {
    
    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return ItalicMarkDownItem.self
    }
}
