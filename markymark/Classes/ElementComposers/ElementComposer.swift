//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

open class ElementComposer<T> {

    /**
     Method that can merge elements of type T into one
     
     - parameter elements: elements to merge
     
     - returns: merged elements
     */
    func compose(_ elements : [T]) -> T {
        fatalError("\(String(describing: self)): Implement \(#function)")
    }
}
