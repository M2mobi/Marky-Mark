//
// Created by Jim van Zummeren on 22/04/16.
// Copyright (c) 2016 M2mobi. All rights reserved.
//

import Foundation

public protocol Flavor {

    /// List of Rules that this flavor has
    var rules:[Rule] { get }
    var defaultRule:Rule { get }

    /// List of Inline rules that this flavor has
    var inlineRules:[InlineRule] { get }
    var defaultInlineRule:InlineRule { get }
}