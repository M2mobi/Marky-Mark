//
//  Created by Jim van Zummeren on 03/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation

open class LinkMarkDownItem: MarkDownItem {

    let title: String?
    let url: String

    public init(lines: [String], content: String, title: String?, url: String) {
        self.url = url
        self.title = title
        super.init(lines: lines, content: content)
    }

    required public init(lines: [String], content: String) {
        fatalError("init(lines:content:) has not been implemented")
    }
}
