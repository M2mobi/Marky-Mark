//
//  Created by Jim van Zummeren on 08/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

/*
 * Image view that can retrieve images from a remote http location
 */

class RemoteImageView : UIImageView {
    
    let file:String
    let altText:String
    
    init(file:String, altText:String) {
        self.file = file
        self.altText = altText
        
        super.init(frame: CGRectZero)
        
        contentMode = .ScaleAspectFit
        
        if let image = UIImage(named: file) {
            self.image = image
            self.addAspectConstraint()
        } else if let url = NSURL(string: file) {
            loadImageFromURL(url)
        } else {
            print("Should display alt text instead: \(altText)")
        }
    }

    //MARK: Private
    
    private func loadImageFromURL(url:NSURL) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {

            let data = NSData(contentsOfURL: url)
            
            dispatch_async(dispatch_get_main_queue(), {
                if let data = data, image = UIImage(data: data) {
                    self.image = image

                    self.addAspectConstraint()
                }
            });
        }
    }
    
    private func addAspectConstraint(){
        if let image = image {
            let constraint = NSLayoutConstraint(
                item: self,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self,
                attribute: .Width,
                multiplier: image.size.height / image.size.width,
                constant: 0
            )
            
            self.addConstraint(constraint)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}