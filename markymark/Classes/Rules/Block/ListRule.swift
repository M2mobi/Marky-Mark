//
// Created by Jim van Zummeren on 02/05/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

protocol ListRule : Rule, HasLevel {
    
    /**
     Level of the list item
     
     For example:
     - Item <- Level 0
       - Item <- Level 1
         - Item <- Level 2
         - Item <- Level 2

     - parameter line: Line to check level of

     - returns: Level of the line
     */

    func getLevel(line:String) -> Int
}