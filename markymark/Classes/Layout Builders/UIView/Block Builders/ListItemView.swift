//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ListItemView : UIView {

    /// List Mark down item to display
    let listMarkDownItem:ListMarkDownItem
    
    /// Label to display the content of the top level list item
    var label:AttributedInteractiveLabel?
    
    /// Forward the attributed text to the label
    var attributedText: NSAttributedString? {
        didSet {
            label?.setAttributedString(attributedText)
        }
    }

    var styling:BulletStylingRule?

    init(listMarkDownItem:ListMarkDownItem, styling: BulletStylingRule?){

        self.listMarkDownItem = listMarkDownItem
        self.styling = styling
        super.init(frame:CGRectZero)

        setUpLayout()
    }
    
    //MARK: Private
    
    /**
     Set up layout for list item with either an image or text as bullet
     */
    
    private func setUpLayout(){
        label = AttributedInteractiveLabel()
        label?.translatesAutoresizingMaskIntoConstraints = false
        label?.numberOfLines = 0

        if let label = label, bullet = getBulletView() {

            addSubview(label)
            addSubview(bullet)

            let views = [
                "label" : label,
                "bullet" : bullet
            ]

            let metrics:[String: AnyObject] = [
                "margin" : 10,
                "bulletWidth" : styling?.bulletViewSize.width ?? 10,
                "bulletHeight" : styling?.bulletViewSize.height ?? 10
            ]

            var constraints:[NSLayoutConstraint] = []

            constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[bullet(bulletWidth)]-[label]-|", options: [], metrics: metrics, views: views)
            constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[bullet(bulletHeight)]", options: [], metrics: metrics, views: views)
            constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: [], metrics: metrics, views: views)

            addConstraints(constraints)
        }
    }

    private func getBulletView() -> UIView? {

        let bulletLabel = UILabel()
        bulletLabel.translatesAutoresizingMaskIntoConstraints = false

        if let hasIndex = listMarkDownItem as? HasIndex {
            bulletLabel.text = "\(hasIndex.indexCharacter)"
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
        
        return nil
    }
    
    private func getImageBulletView() -> UIView? {

        if let styling = styling, image = styling.bulletImage where !(listMarkDownItem is HasIndex) {
            let bulletImageView = UIImageView(image: image)
            bulletImageView.contentMode = .Top
            return bulletImageView
        }

        return nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}