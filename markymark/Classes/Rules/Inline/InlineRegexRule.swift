//
//  Created by Jim van Zummeren on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

protocol InlineRegexRule : InlineRule {
    var expression:NSRegularExpression { get }
}

extension InlineRegexRule {

    func getAllMatches(lines:[String]) -> [NSRange] {
        guard let line = lines.first else { return [] }
        return expression.rangesForString(line)
    }
    
    //MARK: Rule

    func recognizesLines(lines:[String]) -> Bool {
        guard let line = lines.first else { return false }
        let range = NSRange(location: 0, length: line.length())
        let results = expression.matchesInString(line, options:[], range: range)
        return results.count > 0
    }
}