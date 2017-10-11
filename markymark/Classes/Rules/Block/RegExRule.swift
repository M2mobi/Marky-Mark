//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol RegExRule: Rule {
    var expression: NSRegularExpression { get }
}

extension RegExRule {
    public func recognizesLines(_ lines: [String]) -> Bool {
        return expression.hasMatchesInString(lines.first)
    }
}
