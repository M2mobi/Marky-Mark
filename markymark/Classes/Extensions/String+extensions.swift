//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

extension String {

    func subString(start:Int, _ end:Int) -> String {
        let startIndex = self.startIndex.advancedBy(start)
        let endIndex = self.startIndex.advancedBy(end)
        return self.substringWithRange(startIndex..<endIndex)
    }

    func subString(range:NSRange) -> String {
        let startIndex = self.startIndex.advancedBy(range.location)
        let endIndex = self.startIndex.advancedBy(range.getLocationEnd())
        return self.substringWithRange(startIndex..<endIndex)
    }

    func subStringWithExpression(expression:NSRegularExpression, ofGroup group:Int) -> String {
        var subString = ""

        let range = NSRange(location: 0, length: self.characters.count)
        let results = expression.matchesInString(self, options:[], range: range)

        if let result = results.first {
            subString = self.subString(result.rangeAtIndex(group))
        }

        return subString
    }
}