//
//  Created by Jim van Zummeren on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol InlineRegexRule : InlineRule {
    var expression:NSRegularExpression { get }
}

extension InlineRegexRule {

    public func getAllMatches(lines:[String]) -> [NSRange] {
        guard let line = lines.first else { return [] }
        return expression.rangesForString(line)
    }
    
    //MARK: Rule

    public func recognizesLines(lines:[String]) -> Bool {
        guard let line = lines.first else { return false }
        let range = NSRange(location: 0, length: line.length())
        let results = expression.matchesInString(line, options:[], range: range)
        return results.count > 0
    }
}