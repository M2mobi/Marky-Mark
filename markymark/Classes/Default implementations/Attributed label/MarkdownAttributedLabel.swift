//
//  MarkdownAttributedLabel.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation

open class MarkdownAttributedLabel: UIView {

    public let styling = AttributedLabelStyling()

    private var markDownTextView: UIView?

    public var font: UIFont? {
        didSet {
            styling.paragraphStyling.baseFont = font
            reconfigure()
        }
    }

    public var text: String? = nil {
        didSet {
            reconfigure()
        }
    }

    public init(font: UIFont? = nil) {
        self.font = font
        super.init(frame: CGRect())
        configureViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MarkdownAttributedLabel {

    func reconfigure() {
        markDownTextView?.removeFromSuperview()
        markDownTextView = createMarkDownView()
        configureViews()
    }

    func createMarkDownView() -> UIView? {
        guard let markDownString = text else { return nil }

        let markyMark = MarkyMark(build: {
            $0.setFlavor(AttributedLabelFlavor())
        })

        // Parsing to MarkDownItem's
        let markDownItems = markyMark.parseMarkDown(markDownString)

        // Converting to views
        let configuration = MarkdownToViewConverterConfiguration(styling: styling)
        let converter = MarkDownConverter(configuration: configuration)

        return converter.convert(markDownItems)
    }
}

extension MarkdownAttributedLabel: CanConfigureViews {

    public func configureViewHierarchy() {
        guard let markDownTextView = markDownTextView else { return }
        addSubview(markDownTextView)
    }

    public func configureViewLayout() {
        guard let markDownTextView = markDownTextView else { return }

        let views: [String: Any] = [
            "markDownTextView" : markDownTextView
        ]

        var constraints:[NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[markDownTextView]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[markDownTextView]|", options: [], metrics: [:], views: views)
        addConstraints(constraints)
    }
}
