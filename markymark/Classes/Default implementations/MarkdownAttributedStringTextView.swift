//
//  MarkdownAttributedStringTextView.swift
//  Pods
//
//  Created by Jim van Zummeren on 20/03/2022.
//

import Foundation

open class MarkdownAttributedStringTextView: UIView, MarkDownView {

    public var onDidPreconfigureTextView:((_ textView: UITextView) -> Void)?

    public var onDidConvertMarkDownItemToAttributedString:((_ markDownItem: MarkDownItem, _ view: NSMutableAttributedString) -> ())?

    public var styling: DefaultStyling

    public var text: String? = nil {
        didSet {
            render(withMarkdownText: text)
        }
    }

    private var markDownView: UITextView?
    private var markDownItems: [MarkDownItem] = []
    private let markyMark: MarkyMark

    private let configuration: MarkDownToAttributedStringConverterConfiguration
    private let converter: MarkDownConverter<NSMutableAttributedString>

    public init(
        flavor: Flavor = ContentfulFlavor(),
        styling: DefaultStyling = .init()
    ) {
        markyMark = MarkyMark(build: {
            $0.setFlavor(flavor)
        })

        self.styling = styling
        configuration = .init(styling: styling)
        converter = .init(configuration: configuration)

        super.init(frame: CGRect())
    }

    public override init(frame: CGRect) {
        markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        styling = DefaultStyling()

        configuration = .init(styling: styling)
        converter = .init(configuration: configuration)
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        styling = DefaultStyling()

        configuration = .init(styling: styling)
        converter = .init(configuration: configuration)
        super.init(coder: aDecoder)
    }

    public func add(rule: Rule) {
        markyMark.addRule(rule)
    }

    public func add(inlineRule: InlineRule) {
        markyMark.addInlineRule(inlineRule)
    }

    public func addViewLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString>) {
        configuration.addLayoutBlockBuilder(layoutBlockBuilder)
    }

    public func addInlineLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString>) {
        configuration.addInlineLayoutBlockBuilder(layoutBlockBuilder)
    }
}

private extension MarkdownAttributedStringTextView {

    private func render(withMarkdownText markdownText: String?) {
        markDownView?.removeFromSuperview()

        guard let markdownText = markdownText else {
            markDownItems = []
            return
        }

        markDownItems = markyMark.parseMarkDown(markdownText)
        configureViews()
    }
}

extension MarkdownAttributedStringTextView: CanConfigureViews {

    func configureViewProperties() {
        let attributedString = converter.convert(markDownItems)

        let textView = UITextView()

        textView.isScrollEnabled = false
        textView.isEditable = false

        textView.attributedText = attributedString
        textView.dataDetectorTypes = [.phoneNumber, .link]
        textView.attributedText = attributedString

        textView.tintColor = styling.linkStyling.textColor
        textView.translatesAutoresizingMaskIntoConstraints = false

        onDidPreconfigureTextView?(textView)

        markDownView = textView
    }

    func configureViewHierarchy() {
        guard let markDownView = markDownView else { return }
        addSubview(markDownView)
    }

    func configureViewLayout() {
        guard let markDownView = markDownView else { return }

        let views: [String: Any] = [
            "markDownView": markDownView
        ]

        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[markDownView]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[markDownView]|", options: [], metrics: [:], views: views)
        addConstraints(constraints)
    }
}
