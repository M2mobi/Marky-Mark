//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class HorizontalLineRule : RegExRule {

    /// Example: ---

    var expression = NSRegularExpression.expressionWithPattern("(^\\-{3,})$")

    //MARK: Rule

    func createMarkDownItemWithLines(lines:[String]) -> MarkDownItem {
        return HorizontalLineMarkDownItem(lines: lines, content: "")
    }
}