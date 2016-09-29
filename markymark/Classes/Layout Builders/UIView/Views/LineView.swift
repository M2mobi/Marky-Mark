//
//  Created by Jim van Zummeren on 10/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class LineView: UIView {

    var height: CGFloat = 0

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: height)
    }

}
