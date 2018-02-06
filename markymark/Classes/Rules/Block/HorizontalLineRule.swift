//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class HorizontalLineRule: RegExRule {

    public init() {}

    /// Example: ---

    open var expression = NSRegularExpression.expressionWithPattern("(^\\-{3,})$")

    //MARK: Rule

    open func createMarkDownItemWithLines(_ lines: [String]) -> MarkDownItem {
        return HorizontalLineMarkDownItem(lines: lines, content: "")
    }
}
