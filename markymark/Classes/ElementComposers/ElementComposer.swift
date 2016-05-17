//
//  Created by Menno Lovink on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

public class ElementComposer<T> {

    /**
     Method that can merge elements of type T into one
     
     - parameter elements: elements to merge
     
     - returns: merged elements
     */
    func compose(elements : [T]) -> T {
        fatalError("\(String(self)): Implement \(#function)")
    }
}