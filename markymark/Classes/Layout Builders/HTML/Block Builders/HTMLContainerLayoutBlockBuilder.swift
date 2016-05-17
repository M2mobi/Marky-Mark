//
//  HTMLContainerLayoutBlockBuilder.swift
//  MarkyMark
//
//  Created by Menno Lovink on 02/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit

class HTMLContainerLayoutBlockBuilder: LayoutBlockBuilder<String> {

    var htmlTag : String {
        fatalError("\(String(self)): Implement \(#function)")
    }

    // MARK: LayoutBlockBuilder

    override func build(markDownItem:MarkDownItem, asPartOfConverter converter : MarkDownConverter<String>, styling : ItemStyling?) -> String {
        var html = "<\(htmlTag)>"

        if let markDownItems = markDownItem.markDownItems {

            for subHtml in converter.convertToElements(markDownItems) {

                html += subHtml
            }
        }

        html += "</\(htmlTag)>"
        
        return html
    }
}
