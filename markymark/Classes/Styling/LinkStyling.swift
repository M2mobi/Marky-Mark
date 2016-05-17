//
//  Created by Jim van Zummeren on 08/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

public struct LinkStyling: ItemStyling, TextColorStylingRule, UnderlineStylingRule, BoldStylingRule, ItalicStylingRule {
    
    public var parent : ItemStyling? = nil
    
    public func isApplicableOn(markDownItem: MarkDownItem) -> Bool {
        
        return markDownItem is LinkMarkDownItem
    }

    public var textColor: UIColor? = UIColor.brownColor()
    
    public var isBold = false
    public var isItalic = false
    public var isUnderlined = true
}