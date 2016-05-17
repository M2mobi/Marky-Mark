//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public protocol ListItemStylingRule : ItemStyling {

    /// Margin between list items
    var bottomListItemSpacing:CGFloat { get }
    /// Amount of left margin for each level of a nested list
    var listIdentSpace:CGFloat { get }

}