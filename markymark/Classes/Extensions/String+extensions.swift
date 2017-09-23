//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

extension String {

    func subString(_ start:Int, _ end:Int) -> String {
        let startIndex = self.characters.index(self.startIndex, offsetBy: start)
        let endIndex = self.characters.index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }

    func subString(_ range:NSRange) -> String {
        let startIndex = self.characters.index(self.startIndex, offsetBy: range.location)
        let endIndex = self.characters.index(self.startIndex, offsetBy: range.getLocationEnd())
        return String(self[startIndex..<endIndex])
    }

    func subStringWithExpression(_ expression:NSRegularExpression, ofGroup group:Int) -> String {
        var subString = ""
        let range = NSRange(location: 0, length: self.length())
        let results = expression.matches(in: self, options:[], range: range)

        if let result = results.first {
            subString = self.subString(result.range(at: group))
        }

        return subString
    }

    /**
     A faster way of counting Swift strings by using the Objective C implementation

     - returns: Number of characters in the String
     */
    func length() -> Int {
        return (self as NSString).length
    }
}
