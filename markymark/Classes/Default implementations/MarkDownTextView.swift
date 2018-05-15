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

public class MarkDownTextView: UIView {

    public var styling: DefaultStyling

    fileprivate var markDownView: UIView?
    fileprivate var markDownItems: [MarkDownItem] = []
    private let markyMark: MarkyMark

    fileprivate var viewConfiguration: CanConfigureViews?

    public init(markDownConfiguration: MarkDownConfiguration = .view, flavor: Flavor = ContentfulFlavor(), styling: DefaultStyling = DefaultStyling()) {

        markyMark = MarkyMark(build: {
            $0.setFlavor(flavor)
        })

        self.styling = styling
        super.init(frame: CGRect())

        switch markDownConfiguration {
        case .view:
            viewConfiguration = MarkDownAsViewViewConfiguration(owner: self)
        case .attributedString:
            viewConfiguration = MarkDownAsAttributedStringViewConfiguration(owner: self)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(markdownText: String?) {
        markDownView?.removeFromSuperview()

        guard let markdownText = markdownText else {
            markDownItems = []
            return
        }

        markDownItems = markyMark.parseMarkDown(markdownText)
        viewConfiguration?.configureViews()
    }
}

private struct MarkDownAsViewViewConfiguration: CanConfigureViews {

    private weak var owner: MarkDownTextView?

    init(owner: MarkDownTextView) {
        self.owner = owner
    }

    func configureViewProperties() {
        guard let owner = owner else { return }
        let configuration = MarkdownToViewConverterConfiguration(styling: owner.styling)
        let converter = MarkDownConverter(configuration: configuration)

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
            "markDownView" : markDownView
        ]

        var constraints:[NSLayoutConstraint] = []
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
        textView.dataDetectorTypes = .link
        textView.attributedText = attributedString
        textView.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
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
            "markDownView" : markDownView
        ]

        var constraints:[NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[markDownView]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[markDownView]|", options: [], metrics: [:], views: views)
        owner.addConstraints(constraints)
    }
}
