//
//  MarkDownTextView.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation
import UIKit

public enum MarkDownConfiguration {
    case view
    case attributedString
}

@IBDesignable
open class MarkDownTextView: UIView {

    public var onDidConvertMarkDownItemToView:((_ markDownItem: MarkDownItem, _ view: UIView) -> Void)?
    public var onDidConvertMarkDownItemToAttributedString:((_ markDownItem: MarkDownItem, _ view: NSMutableAttributedString) -> ())?
    public var onDidPreconfigureTextView:((_ textView: UITextView) -> Void)?

    public private(set) var styling: DefaultStyling {
        get {
            markDownView.styling
        }
        set {
            markDownView.styling = newValue
        }
    }

    @IBInspectable
    public var text: String? = nil {
        didSet {
            markDownView.text = text
        }
    }

    public var urlOpener: URLOpener? {
        didSet {
            guard let markDownView = markDownView as? MarkdownViewTextView else {
                debugPrint("MarkyMark Warning: Using \(#function) on MarkDownTextView when initialized with MarkDownConfiguration.attributedString has no effect. Consider using MarkDownConfiguration.view instead.")
                return
            }

            markDownView.urlOpener = urlOpener
        }
    }

    private var markDownView: MarkDownView

    public init(markDownConfiguration: MarkDownConfiguration = .view, flavor: Flavor = ContentfulFlavor(), styling: DefaultStyling = DefaultStyling()) {
        var markdownViewTextView: MarkdownViewTextView?
        var markdownAttributedStringTextView: MarkdownAttributedStringTextView?

        if markDownConfiguration == .view {
            markdownViewTextView = MarkdownViewTextView(flavor: flavor, styling: styling)
            markDownView = markdownViewTextView!
        } else {
            markdownAttributedStringTextView = MarkdownAttributedStringTextView(flavor: flavor, styling: styling)
            markDownView = markdownAttributedStringTextView!
        }

        super.init(frame: CGRect())

        markdownViewTextView?.onDidConvertMarkDownItemToView = {
            [weak self] markDownItem, view in
            self?.onDidConvertMarkDownItemToView?(markDownItem, view)
        }

        markdownAttributedStringTextView?.onDidConvertMarkDownItemToAttributedString = {
            [weak self] markDownItem, string in
            self?.onDidConvertMarkDownItemToAttributedString?(markDownItem, string)
        }

        markdownAttributedStringTextView?.onDidPreconfigureTextView = {
            [weak self] in
            self?.onDidPreconfigureTextView?($0)
        }

        configureViews()
    }

    public override init(frame: CGRect) {
        markDownView = MarkdownViewTextView(flavor: ContentfulFlavor(), styling: .init())
        super.init(frame: frame)
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        markDownView = MarkdownViewTextView(flavor: ContentfulFlavor(), styling: .init())
        super.init(coder: aDecoder)
        configureViews()
    }

    public func add(rule: Rule) {
        markDownView.add(rule: rule)
    }

    public func add(inlineRule: InlineRule) {
        markDownView.add(inlineRule: inlineRule)
    }

    public func addViewLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<UIView>) {
        guard let markDownView = markDownView as? MarkdownViewTextView else {
            assertionFailure("MarkyMark Warning: Using \(#function) on MarkDownTextView when initialized with MarkDownConfiguration.attributedString has no effect. Consider using addAttributedStringLayoutBlockBuilder instead.")
            return
        }

        markDownView.addViewLayoutBlockBuilder(layoutBlockBuilder)
    }

    public func addAttributedStringLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString>) {
        guard let markDownView = markDownView as? MarkdownAttributedStringTextView else {
            assertionFailure("MarkyMark Warning: Using \(#function) on MarkDownTextView when initialized with MarkDownConfiguration.view has no effect. Consider using addViewLayoutBlockBuilder instead.")
            return
        }

        markDownView.addViewLayoutBlockBuilder(layoutBlockBuilder)
    }

    public func addInlineLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString>) {
        (markDownView as? MarkdownViewTextView)?.addInlineLayoutBlockBuilder(layoutBlockBuilder)
        (markDownView as? MarkdownAttributedStringTextView)?.addInlineLayoutBlockBuilder(layoutBlockBuilder)
    }
}

extension MarkDownTextView: CanConfigureViews {

    func configureViewProperties() {
        markDownView.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureViewHierarchy() {
        addSubview(markDownView)
    }

    func configureViewLayout() {
        let views: [String: Any] = [
            "markDownView": markDownView
        ]

        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[markDownView]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[markDownView]|", options: [], metrics: [:], views: views)
        addConstraints(constraints)
    }
}

