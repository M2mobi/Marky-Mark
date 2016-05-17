//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

class AlphabeticallyOrderedMarkDownItem : ListMarkDownItem, HasIndex {

    let indexCharacters:[String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

    let index:Int

    var indexCharacter:String {
        return "\(indexCharacters[index])."
    }

    init(lines: [String], content: String, index:Int) {
        self.index = index
        super.init(lines: lines, content: content)
    }

    required init(lines: [String], content: String) {
        fatalError("init(lines:content:) has not been implemented")
    }
}