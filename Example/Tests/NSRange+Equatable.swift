//
//  NSRange+Equatable.swift
//  markymark
//
//  Created by Jim van Zummeren on 29/09/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

extension NSRange: Equatable {}

public func == (lhs: NSRange, rhs: NSRange) -> Bool {
    return lhs.length == rhs.length && lhs.location == rhs.location
}
