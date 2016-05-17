//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public protocol ContentInsetStylingRule : ItemStyling {

    /// Margin from surrounding elements
    var contentInsets : UIEdgeInsets { get }
}