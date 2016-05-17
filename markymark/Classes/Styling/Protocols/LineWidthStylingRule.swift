//
//  Created by Jim van Zummeren on 10/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public protocol LineWidthStylingRule : ItemStyling {
    var lineWidth : CGFloat { get }
}