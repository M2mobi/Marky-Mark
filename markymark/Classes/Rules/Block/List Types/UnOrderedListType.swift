//
//  Created by Jim van Zummeren on 23/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public class UnOrderedListType:ListType {

    var pattern:String {
        return "\\-|\\+|\\*"
    }

    var relatedListMarkDownType: ListMarkDownItem.Type {
        return UnorderedListMarkDownItem.self
    }

    public func getIndex(stringIndex:String) -> Int? {
        return nil
    }
}