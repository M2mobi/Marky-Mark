//
//  Created by Jim van Zummeren on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol InlineRule : Rule {

    /**
     Finds all matches in the given String

     - parameter lines: Lines to find the match in

     - returns: Array of ranges where the matches were found
     */
    
    func getAllMatches(_ lines:[String]) -> [NSRange]
}
