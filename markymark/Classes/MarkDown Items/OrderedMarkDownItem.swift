//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

public class OrderedListMarkDownItem : ListMarkDownItem, HasIndex {

    var index:Int
    var indexCharacter:String {
        return "\(index)."
    }

    init(lines: [String], content: String, index:Int) {
        self.index = index
        super.init(lines: lines, content: content)
    }
    
    required public init(lines: [String], content: String) {
        fatalError("init(lines:content:) has not been implemented")
    }
}