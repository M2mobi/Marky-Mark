//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class ImageRule : InlineRegexRule {

    /// Example: ![Alt text](image.png)
    var expression = NSRegularExpression.expressionWithPattern("!\\[([^]]*)\\]\\(([^]]+?)\\)")

    func createMarkDownItemWithLines(_ lines:[String]) -> MarkDownItem {

        let file:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 2)
        let altText:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 1)
        
        return ImageMarkDownItem(lines: lines, file: file ?? "", altText: altText ?? "")
    }
}
