//
//  Created by Jim van Zummeren on 22/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit
import markymark

class ViewController: UIViewController {

    override func viewDidLoad() {

        self.view = UIScrollView()

        // Toggle this boolean to switch between using the default 'MarkDownView' or using a custom configuration
        // See implementation below for examples of both the default view or a custom configured view for advanced usage
        let useDefaultView = true

        let markDownView = useDefaultView ? getDefaultView() : getViewWithCustomConverterAndCustomParsing()
        view.addSubview(markDownView)

        let views: [String: Any] = [
            "view" : view,
            "markDownView" : markDownView
        ]

        markDownView.translatesAutoresizingMaskIntoConstraints = false

        var constraints: [NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[markDownView(==view)]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[markDownView]|", options: [], metrics: [:], views: views)
        view.addConstraints(constraints)

        super.viewDidLoad()
    }
}

private extension ViewController {

    func getDefaultView() -> UIView {
        let markDownView = MarkDownTextView(markDownConfiguration: .view)
        markDownView.styling.headingStyling.textColorsForLevels = [.orange, .black]
        markDownView.styling.linkStyling.textColor = .blue
        markDownView.styling.listStyling.bulletImages = [
            UIImage(named: "circle"),
            UIImage(named: "emptyCircle"),
            UIImage(named: "line"),
            UIImage(named: "square")
        ]

        markDownView.styling.paragraphStyling.baseFont = .systemFont(ofSize: 14)

        markDownView.set(markdownText: getMarkDownString())
        return markDownView
    }
    
    func getViewWithCustomConverterAndCustomParsing() -> UIView {

        // Parsing to MarkDownItem's
        let markDownString = getMarkDownString()

        let markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        let markDownItems = markyMark.parseMarkDown(markDownString)

        // Configure styling
        let styling = DefaultStyling()
        styling.listStyling.bulletImages = [
            UIImage(named: "circle"),
            UIImage(named: "emptyCircle"),
            UIImage(named: "line"),
            UIImage(named: "square")
        ]

        styling.headingStyling.contentInsetsForLevels = [
            UIEdgeInsets(top: 5, left: 0, bottom: 15, right: 10), // H1
            UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 10) // H2, ...
        ]

        // Only uppercase H1 headers
        styling.headingStyling.capitalizationForLevels = [
            .uppercased, // H1
            nil //H2, ...
        ]

        let configuration = MarkdownToViewConverterConfiguration(styling: styling)
        let converter = MarkDownConverter(configuration: configuration)
        
        return converter.convert(markDownItems)
    }

    func getMarkDownString() -> String {
        var markdownString:String = ""
        if let filepath = Bundle.main.path(forResource: "markdown", ofType: "txt") {
            markdownString = try! String(contentsOfFile: filepath)
        }
        
        return markdownString
    }
}
