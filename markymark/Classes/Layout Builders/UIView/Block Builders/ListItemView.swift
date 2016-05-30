//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ListItemView : UIView {

    var bottomSpace:CGFloat = 0

    /// List Mark down item to display
    let listMarkDownItem:ListMarkDownItem
    
    /// Label to display the content of the top level list item
    var label:AttributedInteractiveLabel = AttributedInteractiveLabel()

    /// bullet view to display the bullet character •, 1. or a. for example(
    var bullet:UIView?

    var styling:BulletStylingRule?

    init(listMarkDownItem:ListMarkDownItem, styling: BulletStylingRule?, attributedText: NSAttributedString){

        self.listMarkDownItem = listMarkDownItem
        self.styling = styling

        super.init(frame:CGRectZero)

        label.setAttributedString(attributedText)
        label.numberOfLines = 0

        setUpLayout()
    }

    override func layoutSubviews() {

        label.sizeToFit()

        if let styling = styling {
            label.frame.size.width = frame.size.width - styling.bulletViewSize.width
            label.frame.origin.x = styling.bulletViewSize.width
            bullet?.frame = CGRect(x: 0, y: 0, width: styling.bulletViewSize.width, height: styling.bulletViewSize.height)
        } else {
            label.frame.size.width = frame.size.width
        }

        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private
    
    /**
     Set up layout for list item with either an image or text as bullet
     */
    
    private func setUpLayout(){
        bullet = getBulletView()
        if let bullet = bullet {

            addSubview(label)
            addSubview(bullet)
        }
    }

    private func getBulletView() -> UIView {

        let bulletLabel = UILabel()

        if let indexCharacter = listMarkDownItem.indexCharacter {
            bulletLabel.text = "\(indexCharacter)"
        } else if styling?.bulletImage == nil {
            bulletLabel.text = "•"
        } else {
            return getImageBulletView()
        }

        if let styling = styling {
            
            if let font = styling.bulletFont {
                bulletLabel.font = font
            }

            if let color = styling.bulletColor {
                bulletLabel.textColor = color
            }

            return bulletLabel
        }
        
        return UIView()
    }
    
    private func getImageBulletView() -> UIView {

        if let styling = styling, image = styling.bulletImage {
            let bulletImageView = UIImageView(image: image)
            bulletImageView.contentMode = .Top
            return bulletImageView
        }

        return UIView()
    }

    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 0, height: self.label.frame.size.height + bottomSpace)
    }

}