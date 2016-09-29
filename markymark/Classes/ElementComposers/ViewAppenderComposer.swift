//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ViewAppenderComposer: ElementComposer<UIView> {

    override func compose(_ elements: [UIView]) -> UIView {

        let container = UIView()
        let viewAppender = AutoLayoutViewAppender(container:container)

        for element in elements {
            viewAppender.appendView(element, verticalMargin: 0, horizontalMargin: 0)
        }
        
        viewAppender.finishAppendingWithPadding(0)
        
        return container
    }
}
