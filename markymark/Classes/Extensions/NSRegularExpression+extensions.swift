//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

extension NSRegularExpression {

    public static func expressionWithPattern(_ pattern:String) -> NSRegularExpression {
        let options:NSRegularExpression.Options  = [.caseInsensitive]
        return try! NSRegularExpression(pattern:pattern, options:options);
    }

    func hasMatchesInString(_ string:String?) -> Bool {
        guard let string = string else { return false }
        let range = NSRange(location: 0, length: string.length())
        let results = matches(in: string, options:[], range: range)
        return results.count > 0
    }

    func rangeInString(_ string:String, forGroup group:Int) -> NSRange? {
        let range = NSRange(location: 0, length: string.length())

        let results = matches(in: string, options:[], range: range)

        return results.first?.range(at: group)
    }

    func rangesForString(_ string:String) -> [NSRange] {
        let range = NSRange(location: 0, length:string.length())
        let results = matches(in: string, options:[], range: range)
        return results.map { $0.range }
    }
}
