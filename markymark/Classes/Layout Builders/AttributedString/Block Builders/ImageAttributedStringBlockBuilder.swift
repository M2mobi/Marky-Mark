//
//  Created by Jim van Zummeren on 05/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ImageAttributedStringBlockBuilder : LayoutBlockBuilder<NSMutableAttributedString> {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return ImageMarkDownItem.self
    }

    override func build(markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<NSMutableAttributedString>, styling : ItemStyling) -> NSMutableAttributedString {
        let imageMarkDownItem = markDownItem as! ImageMarkDownItem

        let attachment = NSTextAttachment()
        
        if let image = UIImage(named: imageMarkDownItem.file) {
            attachment.image = image
        }

        let mutableAttributedString = NSAttributedString(attachment: attachment)

        return mutableAttributedString as! NSMutableAttributedString
    }
}