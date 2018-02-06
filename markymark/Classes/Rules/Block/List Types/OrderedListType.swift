//
//  Created by Jim van Zummeren on 23/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class OrderedListType: ListType {

    public init() {}

    public var pattern: String {
        return "\\d\\."
    }

    public var relatedListMarkDownType: ListMarkDownItem.Type {
        return OrderedListMarkDownItem.self
    }

    open func getIndex(_ stringIndex: String) -> Int? {
        var stringIndex = stringIndex
        stringIndex = stringIndex.replacingOccurrences(of: ".", with: "")

        return Int(stringIndex)
    }
}
