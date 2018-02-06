//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class ImageRule : InlineRegexRule {
    
    public init() {}

    /// Example: ![Alt text](image.png)
    public var expression = NSRegularExpression.expressionWithPattern("!\\[([^]]*)\\]\\(([^]]+?)\\)")


    public func createMarkDownItemWithLines(_ lines:[String]) -> MarkDownItem {

        let file:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 2)
        let altText:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 1)
        
        return ImageMarkDownItem(lines: lines, file: file ?? "", altText: altText ?? "")
    }
}
