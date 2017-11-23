//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class ImageMarkDownItem : MarkDownItem {

    public let file:String
    public let altText:String
    
    init(lines: [String], file: String, altText:String) {
        self.file = file
        self.altText = altText
        super.init(lines: lines, content: altText)
    }
    
    required public init(lines: [String], content: String) {
        fatalError("init(lines:content:) has not been implemented")
    }
}
