//
//  Created by Jim van Zummeren on 05/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class InlineImageAttributedStringBlockBuilder : LayoutBlockBuilder<NSMutableAttributedString> {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return ImageMarkDownItem.self
    }

    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<NSMutableAttributedString>, styling : ItemStyling) -> NSMutableAttributedString {
        let imageMarkDownItem = markDownItem as! ImageMarkDownItem

        let attachment = TextAttachment()
        
        if let image = UIImage(named: imageMarkDownItem.file) {
            attachment.image = image
        } else if let url = URL(string: imageMarkDownItem.file) {
            //TODO: This makes remote inline images blocking..
            let data = try? Data(contentsOf: url)
            if let data = data, let image = UIImage(data: data) {
                attachment.image = image
            }
        }
        
        if attachment.image == nil {
            return NSMutableAttributedString()
        }
        
        let mutableAttributedString = NSAttributedString(attachment: attachment)

        return mutableAttributedString as! NSMutableAttributedString
    }
}
