//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

protocol HasIndex {
    /// Index as number
    var index:Int? { get }

    /// Index as String. For example: 1. 2. 3. or A. B. C.
    var indexCharacter:String? { get }
}