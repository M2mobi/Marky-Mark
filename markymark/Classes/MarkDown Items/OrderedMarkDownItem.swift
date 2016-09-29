//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class OrderedListMarkDownItem : ListMarkDownItem {

    override var indexCharacter:String? {
        return "\(index ?? 0)."
    }
}
