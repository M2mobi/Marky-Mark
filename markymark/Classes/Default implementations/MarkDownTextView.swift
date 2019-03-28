//
//  MarkDownTextView.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation

public enum MarkDownConfiguration {
    case view
    case attributedString
}

@IBDesignable
public class MarkDownTextView: UIView {

    public var onDidConvertMarkDownItemToView:((_ markDownItem: MarkDownItem, _ view: UIView) -> Void)?

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

    var urlOpener: URLOpener?
    var onDidConvertMarkDownItemToView:((_ markDownItem: MarkDownItem, _ view: UIView) -> Void)?

    private weak var owner: MarkDownTextView?

    init(owner: MarkDownTextView) {
        self.owner = owner
    }

    func configureViewProperties() {
        guard let owner = owner else { return }
        let configuration = MarkdownToViewConverterConfiguration(styling: owner.styling, urlOpener: urlOpener)
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

private struct MarkDownAsAttributedStringViewConfiguration: CanConfigureViews {

    private weak var owner: MarkDownTextView?

    init(owner: MarkDownTextView) {
        self.owner = owner
    }

    func configureViewProperties() {
        guard let owner = owner  else { return }
        let configuration = MarkDownToAttributedStringConverterConfiguration(styling: owner.styling)
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
