//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class LinkRule : InlineRegexRule {
    
    /// Example: [Google](http://www.google.com)
    var pattern:String = "(?<!!\\p{Z}{0,1})\\[{1}(.+?)\\]\\({1}(.+?)\\)"
    
    //MARK: Rule

    func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        
        let url:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 2)
        let content:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 1)

        return LinkMarkDownItem(lines: lines, content: content ?? "", url: url ?? "")
    }
    
}