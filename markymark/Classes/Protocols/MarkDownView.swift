//
//  MarkDownView.swift
//  Pods
//
//  Created by Jim van Zummeren on 21/03/2022.
//

import Foundation

protocol MarkDownView: UIView {
    var text: String? { get set }
    var styling: DefaultStyling { get set }
    func add(rule: Rule)
    func add(inlineRule: InlineRule)
}
