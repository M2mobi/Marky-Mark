//
//  CanConfigureViews.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation

public protocol CanConfigureViews {

    func configureViews()
    func configureViewProperties()
    func configureViewEvents()
    func configureViewHierarchy()
    func configureViewLayout()
}

public extension CanConfigureViews {

    func configureViews() {
        configureViewProperties()
        configureViewEvents()
        configureViewHierarchy()
        configureViewLayout()
    }

    func configureViewProperties() {}
    func configureViewEvents() {}
    func configureViewHierarchy() {}
    func configureViewLayout() {}
}
