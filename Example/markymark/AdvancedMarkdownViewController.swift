//
//  AdvancedMarkdownViewController.swift
//  markymark_Example
//
//  Created by Jim van Zummeren on 23/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import markymark

class AdvancedMarkdownViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollView = UIScrollView()
        view.addSubview(scrollView)

        let markDownView = getMarkDownView()
        scrollView.addSubview(markDownView)

        let views: [String: Any] = [
            "view": view,
            "scrollView": scrollView,
            "markDownView": markDownView
            ]

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        markDownView.translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[markDownView(==scrollView)]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[markDownView]|", options: [], metrics: [:], views: views)
        view.addConstraints(constraints)
    }
}

private extension AdvancedMarkdownViewController {

    func getMarkDownView() -> UIView {

        // Parsing to MarkDownItem's
        let markDownString = getMarkDownString()

        let markyMark = MarkyMark(build: {
            // Choose flavor (set of rules)
            $0.setFlavor(ContentfulFlavor())

            //Example: Add single custom rules
            //$0.addRule(CustomHeaderRule())
        })

        let markDownItems = markyMark.parseMarkDown(markDownString)

        // Configure styling, see README for more styling options or Implement your own Styling object instead of DefaultStyling.
        let styling = DefaultStyling()
        styling.listStyling.bulletImages = [
            UIImage(named: "circle"),
            UIImage(named: "emptyCircle"),
            UIImage(named: "line"),
            UIImage(named: "square")
        ]

        styling.headingStyling.contentInsetsForLevels = [
            UIEdgeInsets(top: 16, left: 6, bottom: 15, right: 10), // H1
            UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 10) // H2, ...
        ]

        styling.headingStyling.textColorsForLevels = [
            .red,  // H1
            .black, // H2
            .gray // H3, ...
        ]

        // Only uppercase H1 headers
        styling.headingStyling.capitalizationForLevels = [
            .uppercased, // H1
            nil //H2, ...
        ]

        let configuration = MarkdownToViewConverterConfiguration(styling: styling)
        let converter = MarkDownConverter(configuration: configuration)

        // Converter hook, only meant for very specific (otherwise impossible) usecases. The hook is triggered every time a MarkdownItem is converted to a view.
        // In this example the headers are rotated, which is normally not supported in MarkyMark styling.
        converter.didConvertElement = {
            markdownItem, view in

            // When a header is converted and it's H1, rotate it slighly for example
            if let headerMarkDownItem = markdownItem as? HeaderMarkDownItem, headerMarkDownItem.level == 1 {
                view.transform = CGAffineTransform(rotationAngle: -0.07)
            }
        }

        return converter.convert(markDownItems)
    }

    func getMarkDownString() -> String {
        var markdownString: String = ""
        if let filepath = Bundle.main.path(forResource: "markdown", ofType: "txt") {
            markdownString = try! String(contentsOfFile: filepath)
        }

        return markdownString
    }
}
