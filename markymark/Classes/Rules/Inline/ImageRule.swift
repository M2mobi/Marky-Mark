//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class ImageRule : InlineRegexRule {

    /// Example: ![Alt text](image.png)    
    var pattern = "(!\\p{Z}{0,1})\\[{1}(.+?)\\]\\({1}(.+?)\\)"

    func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {

        let file:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 3)
        let altText:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 2)
        
        return ImageMarkDownItem(lines: lines, file: file ?? "", altText: altText ?? "")
    }
}
