//
//  MarkDownTextView.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation

open class MarkdownViewTextView: UIView, MarkDownView {

    public var onDidConvertMarkDownItemToView:((_ markDownItem: MarkDownItem, _ view: UIView) -> ())?

    public var styling: DefaultStyling

    public var text: String? = nil {
        didSet {
            render(withMarkdownText: text)
        }
    }

    public var urlOpener: URLOpener? {
        didSet {
            configuration.urlOpener = urlOpener
            render(withMarkdownText: text)
        }
    }

    private var markDownView: UIView?
    private var markDownItems: [MarkDownItem] = []
    private let markyMark: MarkyMark

    private let configuration: MarkdownToViewConverterConfiguration
    private let converter: MarkDownConverter<UIView>

    public init(
        flavor: Flavor = ContentfulFlavor(),
        styling: DefaultStyling = .init()
    ) {
        markyMark = MarkyMark(build: {
            $0.setFlavor(flavor)
        })

        self.styling = styling
        configuration = .init(styling: styling, urlOpener: urlOpener)
        converter = .init(configuration: configuration)

        super.init(frame: CGRect())
    }

    public override init(frame: CGRect) {
        markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        styling = DefaultStyling()

        configuration = .init(styling: styling, urlOpener: urlOpener)
        converter = .init(configuration: configuration)
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        styling = DefaultStyling()

        configuration = .init(styling: styling, urlOpener: urlOpener)
        converter = .init(configuration: configuration)
        super.init(coder: aDecoder)
    }

    public func add(rule: Rule) {
        markyMark.addRule(rule)
    }

    public func add(inlineRule: InlineRule) {
        markyMark.addInlineRule(inlineRule)
    }

    public func addViewLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<UIView>) {
        configuration.addLayoutBlockBuilder(layoutBlockBuilder)
    }

    public func addInlineLayoutBlockBuilder(_ layoutBlockBuilder: LayoutBlockBuilder<NSMutableAttributedString>) {
        configuration.addInlineLayoutBlockBuilder(layoutBlockBuilder)
    }
}

private extension MarkdownViewTextView {

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

extension MarkdownViewTextView: CanConfigureViews {

    func configureViewProperties() {
        converter.didConvertElement = {
            [weak self] markDownItem, view in
            self?.onDidConvertMarkDownItemToView?(markDownItem, view)
        }

        markDownView = converter.convert(markDownItems)
        markDownView?.isUserInteractionEnabled = true
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
