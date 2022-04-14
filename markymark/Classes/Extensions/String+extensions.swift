//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

extension String {

    func subString(_ start: Int, _ end: Int) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }

    func subString(_ range: NSRange) -> String {
        guard let range = Range(range, in: self) else { return "" }
        let startIndex = self.distance(from: self.startIndex, to: range.lowerBound)
        let endIndex = self.distance(from: self.startIndex, to: range.upperBound)
        return subString(startIndex, endIndex)
    }

    func optionalSubString(_ range: NSRange) -> String? {
        guard range.location != NSNotFound else { return nil }
        return subString(range)
    }

    public func subStringWithExpression(_ expression: NSRegularExpression, ofGroup group: Int) -> String {
        optionalSubStringWithExpression(expression, ofGroup: group) ?? ""
    }

    public func optionalSubStringWithExpression(_ expression: NSRegularExpression, ofGroup group: Int) -> String? {
        let range = NSRange(location: 0, length: self.length())
        let results = expression.matches(in: self, options: [], range: range)

        if let result = results.first {
            return optionalSubString(result.range(at: group))
        }

        return nil
    }

    /**
     A faster way of counting Swift strings by using the Objective C implementation

     - returns: Number of characters in the String
     */
    func length() -> Int {
        return (self as NSString).length
    }
}
