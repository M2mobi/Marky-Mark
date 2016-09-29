//
//  Created by Jim van Zummeren on 27/05/16.
//
//

import UIKit

class ListView : UIView {

    let styling:ItemStyling

    init(styling:ItemStyling) {
        self.styling = styling
        super.init(frame:CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        var previousView:UIView? = nil

        for subview in subviews {
            
            var y:CGFloat = 0
            var x:CGFloat = 0
            let width:CGFloat = frame.size.width

            if let previousView = previousView {
                y = previousView.frame.origin.y + previousView.intrinsicContentSize.height
            }

            if subview is ListView {
                let listStyling = styling as? ListItemStylingRule
                x = listStyling?.listIdentSpace ?? 10
            }
            
            subview.frame = CGRect(x: x, y: y, width: width - x, height: subview.intrinsicContentSize.height)

            previousView = subview
        }
        
        invalidateIntrinsicContentSize()
    }

    override var intrinsicContentSize : CGSize {

        var height:CGFloat = 0

        for subview in subviews {
            height = height + subview.intrinsicContentSize.height
        }

        return CGSize(width:frame.size.width, height: height)
    }

}
