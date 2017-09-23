//
//  Created by Jim van Zummeren on 08/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class LinkViewLayoutBlockBuilder: ContainerAttributedStringBlockBuilder {
    
    //MARK: LayoutBuilder
    
    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return LinkMarkDownItem.self
    }
    
    override func build(_ markDownItem: MarkDownItem, asPartOfConverter converter: MarkDownConverter<NSMutableAttributedString>, styling : ItemStyling?) -> NSMutableAttributedString {
        let linkMarkDownItem = markDownItem as! LinkMarkDownItem
        
        let attributedString = super.build(markDownItem, asPartOfConverter: converter, styling: styling)
        
        let url = URL(string: linkMarkDownItem.url)
        
        if let url = url {
            attributedString.addAttributes([.link : url ], range: attributedString.fullRange())
        }

        return attributedString
    }
}
