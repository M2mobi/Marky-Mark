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

    public var onDidConvertMarkDownItemToView:((_ markDownItem: MarkDownItem, _ view: UIView) -> Void)? {
        didSet {
            (viewConfiguration as? MarkDownAsViewViewConfiguration)?.onDidConvertMarkDownItemToView = onDidConvertMarkDownItemToView
        }
    }

    public var onDidPreconfigureTextView:((_ textView: UITextView) -> Void)?

    public private(set) var styling: DefaultStyling

    @IBInspectable
    public var text: String? = nil {
        didSet {
            render(withMarkdownText: text)
        }
    }

    public var urlOpener: URLOpener? {
        didSet {
            (viewConfiguration as? MarkDownAsViewViewConfiguration)?.urlOpener = urlOpener
            render(withMarkdownText: text)
        }
    }

    fileprivate var markDownView: UIView?
    fileprivate var markDownItems: [MarkDownItem] = []
    private let markyMark: MarkyMark

    private var viewConfiguration: CanConfigureViews?

    public init(markDownConfiguration: MarkDownConfiguration = .view, flavor: Flavor = ContentfulFlavor(), styling: DefaultStyling = DefaultStyling()) {

        markyMark = MarkyMark(build: {
            $0.setFlavor(flavor)
        })

        self.styling = styling
        super.init(frame: CGRect())

        switch markDownConfiguration {
        case .view:
            let markDownToViewConfiguration = MarkDownAsViewViewConfiguration(owner: self)
            markDownToViewConfiguration.onDidConvertMarkDownItemToView = {
                [weak self] markDownItem, view in
                self?.onDidConvertMarkDownItemToView?(markDownItem, view)
            }

            viewConfiguration = markDownToViewConfiguration
        case .attributedString:
            viewConfiguration = MarkDownAsAttributedStringViewConfiguration(owner: self)
        }
    }

    public override init(frame: CGRect) {
        markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        styling = DefaultStyling()
        super.init(frame: frame)

        viewConfiguration = MarkDownAsViewViewConfiguration(owner: self)
    }

    required public init?(coder aDecoder: NSCoder) {
        markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        styling = DefaultStyling()
        super.init(coder: aDecoder)

        viewConfiguration = MarkDownAsViewViewConfiguration(owner: self)
    }

    public func add(rule: Rule) {
        markyMark.addRule(rule)
    }

    public func addViewLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<UIView>) {
        (viewConfiguration as? MarkDownAsViewViewConfiguration)?.addLayoutBlockBuilder(layoutBlockBuilder)
    }

    public func addAttributedStringLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString>) {
        (viewConfiguration as? MarkDownAsAttributedStringViewConfiguration)?.addLayoutBlockBuilder(layoutBlockBuilder)
    }

    private func render(withMarkdownText markdownText: String?) {
        markDownView?.removeFromSuperview()

        guard let markdownText = markdownText else {
            markDownItems = []
            return
        }

        markDownItems = markyMark.parseMarkDown(markdownText)
        viewConfiguration?.configureViews()
    }
}

private class MarkDownAsViewViewConfiguration: CanConfigureViews {

    var urlOpener: URLOpener? {
        didSet {
            configuration.urlOpener = urlOpener
        }
    }

    var onDidConvertMarkDownItemToView:((_ markDownItem: MarkDownItem, _ view: UIView) -> Void)?

    private let configuration: MarkdownToViewConverterConfiguration

    private weak var owner: MarkDownTextView?

    init(owner: MarkDownTextView) {
        self.owner = owner
        configuration = MarkdownToViewConverterConfiguration(styling: owner.styling, urlOpener: urlOpener)
    }

    func addLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<UIView>) {
        configuration.addLayoutBlockBuilder(layoutBlockBuilder)
    }

    func configureViewProperties() {
        guard let owner = owner else { return }
        let converter = MarkDownConverter(configuration: configuration)

        converter.didConvertElement = {
            [weak self] markDownItem, view in
            self?.onDidConvertMarkDownItemToView?(markDownItem, view)
        }

        owner.markDownView = converter.convert(owner.markDownItems)
        owner.markDownView?.isUserInteractionEnabled = true
    }

    func configureViewHierarchy() {
        guard let owner = owner, let markDownView = owner.markDownView else { return }
        owner.addSubview(markDownView)
    }

    func configureViewLayout() {
        guard let owner = owner, let markDownView = owner.markDownView else { return }

        let views: [String: Any] = [
            "markDownView": markDownView
        ]

        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[markDownView]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[markDownView]|", options: [], metrics: [:], views: views)
        owner.addConstraints(constraints)
    }
}

private class MarkDownAsAttributedStringViewConfiguration: CanConfigureViews {

    private weak var owner: MarkDownTextView?

    private let configuration: MarkDownToAttributedStringConverterConfiguration

    init(owner: MarkDownTextView) {
        self.owner = owner
        configuration = MarkDownToAttributedStringConverterConfiguration(styling: owner.styling)
    }

    open func addLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString>) {
        configuration.addLayoutBlockBuilder(layoutBlockBuilder)
    }

    func configureViewProperties() {
        guard let owner = owner  else { return }
        let converter = MarkDownConverter(configuration: configuration)
        let attributedString = converter.convert(owner.markDownItems)

        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false

        textView.attributedText = attributedString
        textView.dataDetectorTypes = [.phoneNumber, .link]
        textView.attributedText = attributedString

        textView.tintColor = owner.styling.linkStyling.textColor
        textView.translatesAutoresizingMaskIntoConstraints = false

        owner.onDidPreconfigureTextView?(textView)

        owner.markDownView = textView
    }

    func configureViewHierarchy() {
        guard let owner = owner, let markDownView = owner.markDownView else { return }
        owner.addSubview(markDownView)
    }

    func configureViewLayout() {
        guard let owner = owner, let markDownView = owner.markDownView else { return }

        let views: [String: Any] = [
            "markDownView": markDownView
        ]

        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[markDownView]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[markDownView]|", options: [], metrics: [:], views: views)
        owner.addConstraints(constraints)
    }
}
