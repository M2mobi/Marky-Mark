//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public class ImageBlockRule : RegExRule {

    /// Example: ![Alt text](image.png)

    public var expression = NSRegularExpression.expressionWithPattern("^(!\\p{Z}{0,1})\\[{1}(.+?)\\]\\({1}(.+?)\\)$")

    //MARK: Rule

    public func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {

        let file:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 3)
        let altText:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 2)

        return ImageBlockMarkDownItem(lines: lines, file: file ?? "", altText: altText ?? "")
    }
}