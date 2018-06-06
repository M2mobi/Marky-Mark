//
//  CanConfigureViews.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation

protocol CanConfigureViews {

    func configureViews()
    func configureViewProperties()
    func configureViewEvents()
    func configureViewHierarchy()
    func configureViewLayout()
}

extension CanConfigureViews {

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
