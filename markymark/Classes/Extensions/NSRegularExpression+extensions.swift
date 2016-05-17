//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

extension NSRegularExpression {

    static func expressionWithPattern(pattern:String) -> NSRegularExpression {
        let options:NSRegularExpressionOptions  = [.CaseInsensitive, .AnchorsMatchLines]
        return try! NSRegularExpression(pattern:pattern, options:options);
    }

    func hasMatchesInString(string:String?) -> Bool {
        guard let string = string else { return false }
        let range = NSRange(location: 0, length: string.characters.count)
        let results = self.matchesInString(string, options:[], range: range)
        return results.count > 0
    }

    func rangeInString(string:String, forGroup group:Int) -> NSRange? {
        let range = NSRange(location: 0, length: string.characters.count)
        let results = self.matchesInString(string, options:[], range: range)

        return results.first?.rangeAtIndex(group)
    }

    func rangesForString(string:String) -> [NSRange] {
        let range = NSRange(location: 0, length: string.characters.count)
        let results = self.matchesInString(string, options:[], range: range)
        return results.map { $0.range }
    }
}