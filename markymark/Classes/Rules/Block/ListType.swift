//
//  Created by Jim van Zummeren on 23/05/16.
//  Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol ListType {

    /// Regular expression that recognizes the index of the ListType
    /// For example "\\-" would do for a simple list
    var pattern: String { get }

    /// The type of ListMarkDownItem to create if the index is recognized
    var relatedListMarkDownType: ListMarkDownItem.Type { get }

    /**
     Translated the stringIndex to an Int starting with 0
     For example: In an alphabetic list, "c." should be converted to 2
     - parameter stringIndex: Index of the list as string

     - returns: index of the list item as Int
     */
    func getIndex(_ stringIndex: String) -> Int?
    
}
