//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ImageViewLayoutBlockBuilder : LayoutBlockBuilder<UIView> {

    //MARK: LayoutBuilder

    override func relatedMarkDownItemType() -> MarkDownItem.Type {
        return ImageBlockMarkDownItem.self
    }

    override func build(_ markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<UIView>, styling : ItemStyling) -> UIView {
        let imageBlockMarkDownItem = markDownItem as! ImageBlockMarkDownItem

        let imageView = RemoteImageView(file: imageBlockMarkDownItem.file, altText: imageBlockMarkDownItem.altText)
        
        let spacing:UIEdgeInsets? = (styling as? ContentInsetStylingRule)?.contentInsets
        return ContainerView(view: imageView, spacing: spacing)
    }
}
