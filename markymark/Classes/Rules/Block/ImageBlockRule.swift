//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class ImageBlockRule: RegExRule {

    public init() {}

    /// Example: ![Alt text](image.png)

    open var expression = NSRegularExpression.expressionWithPattern("^(!\\p{Z}{0,1})\\[{0,1}(.+?)\\]\\({1}(.+?)\\)$")

    //MARK: Rule

    open func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {

        let file:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 3)
        let altText:String? =  lines.first?.subStringWithExpression(expression, ofGroup: 2)

        return ImageBlockMarkDownItem(lines: lines, file: file ?? "", altText: altText ?? "")
    }
}
