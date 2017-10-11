//
//  Created by Jim van Zummeren on 23/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class UnOrderedListType: ListType {
    
    public init() {}

    public var pattern: String {
        return "\\-|\\+|\\*"
    }

    public var relatedListMarkDownType: ListMarkDownItem.Type {
        return UnorderedListMarkDownItem.self
    }

    open func getIndex(_ stringIndex: String) -> Int? {
        return nil
    }
}
