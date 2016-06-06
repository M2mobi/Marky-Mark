//
//  Created by Jim van Zummeren on 23/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public class OrderedListType:ListType {

    var pattern:String {
        return "\\d\\."
    }

    var relatedListMarkDownType: ListMarkDownItem.Type {
        return OrderedListMarkDownItem.self
    }

    public func getIndex(stringIndex:String) -> Int? {
        var stringIndex = stringIndex
        stringIndex = stringIndex.stringByReplacingOccurrencesOfString(".", withString: "")

        return Int(stringIndex)
    }
}
