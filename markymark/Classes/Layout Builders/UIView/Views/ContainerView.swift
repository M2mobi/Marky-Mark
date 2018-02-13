//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

/*
 * Container view that allows adding margin to any given view
 */

class ContainerView : UIView {

    init(view:UIView, spacing:UIEdgeInsets? = nil) {
        super.init(frame: CGRect())

        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let views = ["view" : view ]

        let metrics: [String: CGFloat] = [
            "top" : spacing?.top ?? 0,
            "left" : spacing?.left ?? 0,
            "bottom" : spacing?.bottom ?? 0,
            "right" : spacing?.right ?? 0
        ]

        var constraints:[NSLayoutConstraint] = []

        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left)-[view]-(right)-|", options: [], metrics: metrics, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(top)-[view]-(bottom)-|", options: [], metrics: metrics, views: views)

        addConstraints(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
