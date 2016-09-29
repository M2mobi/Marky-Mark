//
// Created by Jim van Zummeren on 28/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

class LayoutBuilder<T> {

    func build(_ layoutBlocks:[MarkDownItem]) -> T {
        fatalError("\(String(describing: self)): Implement build")
    }

}
