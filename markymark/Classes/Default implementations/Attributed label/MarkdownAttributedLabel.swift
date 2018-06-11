//
//  MarkdownAttributedLabel.swift
//  markymark
//
//  Created by Jim van Zummeren on 15/05/2018.
//

import Foundation

@IBDesignable
open class MarkdownAttributedLabel: AttributedInteractiveLabel {

    public let styling = AttributedLabelStyling()

    override open var font: UIFont? {
        didSet {
            styling.paragraphStyling.baseFont = font
            markDownAttributedString = attributedText
        }
    }

    override open var textColor: UIColor? {
        didSet {
            styling.paragraphStyling.textColor = textColor
            markDownAttributedString = attributedText
        }
    }

    override open var text: String? {
        didSet {
            if let attributedText = createMarkDownAttributedString(markDownText: text) {
                markDownAttributedString = attributedText
            }
        }
    }

    override open var textAlignment: NSTextAlignment {
        didSet {
            styling.paragraphStyling.textAlignment = markyMarkTextAlignment(ofTextAlignment: textAlignment)
            markDownAttributedString = attributedText
        }
    }

    public init(font: UIFont? = nil) {
        super.init()
        self.font = font
        configureViewProperties()
    }

    override public init(frame: CGRect) {
        super.init(frame: CGRect())
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViewProperties()

        styling.paragraphStyling.baseFont = font
        styling.paragraphStyling.textColor = textColor
        styling.paragraphStyling.textAlignment = markyMarkTextAlignment(ofTextAlignment: textAlignment)

        if let attributedText = createMarkDownAttributedString(markDownText: text) {
            markDownAttributedString = attributedText
        }
    }
}

private extension MarkdownAttributedLabel {

    func createMarkDownAttributedString(markDownText: String?) -> NSAttributedString? {
        guard let markDownText = markDownText else { return nil }

        let markyMark = MarkyMark(build: {
            $0.setFlavor(AttributedLabelFlavor())
        })

        // Parsing to MarkDownItem's
        let markDownItems = markyMark.parseMarkDown(markDownText)

        // Converting to views
        let configuration = MarkDownToAttributedStringConverterConfiguration(styling: styling)
        let converter = MarkDownConverter(configuration: configuration)

        return converter.convert(markDownItems)
    }

    func markyMarkTextAlignment(ofTextAlignment textAlignment: NSTextAlignment) -> TextAlignment {
        let markyMarkTextAlignment: TextAlignment

        switch textAlignment {
        case .left:
            markyMarkTextAlignment = .left
        case .right:
            markyMarkTextAlignment = .right
        case .center:
            markyMarkTextAlignment = .center
        default:
            markyMarkTextAlignment = .left
        }

        return markyMarkTextAlignment
    }
}
