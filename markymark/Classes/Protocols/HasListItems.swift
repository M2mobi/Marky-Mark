//
//  Created by Jim van Zummeren on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

protocol HasListItems {
    /// Array of nested list items
    var listItems:[ListMarkDownItem]? { get set }
}