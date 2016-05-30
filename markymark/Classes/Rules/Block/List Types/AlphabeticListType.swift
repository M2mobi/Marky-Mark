//
//  Created by Jim van Zummeren on 23/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public class AlphabeticListType:ListType {

    var pattern:String {
        return "[a-zA-Z]\\."
    }

    var relatedListMarkDownType: ListMarkDownItem.Type {
        return AlphabeticallyOrderedMarkDownItem.self
    }

    public func getIndex(stringIndex:String) -> Int? {
        let alphabeticIndexCharacters = "abcdefghijklmnopqrstuvwxyz"

        var stringIndex = stringIndex
        stringIndex = stringIndex.stringByReplacingOccurrencesOfString(".", withString: "")

        if let index = alphabeticIndexCharacters.rangeOfString(stringIndex)?.startIndex {
            return alphabeticIndexCharacters.startIndex.distanceTo(index)
        }

        return nil
    }
}