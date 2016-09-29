//
//  Created by Jim van Zummeren on 04/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class AlphabeticallyOrderedMarkDownItem: ListMarkDownItem {

    let indexCharacters: [String] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]

    override var indexCharacter: String? {
        return "\(indexCharacters[index ?? 0])."
    }
}
