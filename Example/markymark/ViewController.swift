//
//  Created by Jim van Zummeren on 22/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit
import markymark

enum ConverterConfiguration {
    case view
    case attributedString
}

class ViewController: UIViewController {

    override func viewDidLoad() {

        self.view = UIScrollView()
        
        //Change this constant to try different configurations
        let converterConfiguration = ConverterConfiguration.view
        
        //MarkyMark
        let markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        let markDownItems = markyMark.parseMarkDown(getMarkDownString())

        let markDownView: UIView
        switch converterConfiguration {
            case .view:
            markDownView = getViewWithViewConverter(markDownItems)
            case .attributedString:
            markDownView = getViewWithAttributedStringConverter(markDownItems)
        }
        
        // Layout
        view.addSubview(markDownView)

        let views: [String: Any] = [
            "view" : view,
            "markDownView" : markDownView
        ]

        markDownView.translatesAutoresizingMaskIntoConstraints = false

        var constraints:[NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[markDownView(==view)]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|[markDownView]|", options: [], metrics: [:], views: views)
        view.addConstraints(constraints)

        super.viewDidLoad()
    }
}

private extension ViewController {
    
    func getViewWithViewConverter(_ markDownItems: [MarkDownItem]) -> UIView {
        let styling = DefaultStyling()
        
        let configuration = MarkdownToViewConverterConfiguration(styling: styling)
        let converter = MarkDownConverter(configuration: configuration)
        
        return converter.convert(markDownItems)
    }
    
    func getViewWithAttributedStringConverter(_ markDownItems: [MarkDownItem]) -> UIView {
        let styling = DefaultStyling()
        let configuration = MarkDownToAttributedStringConverterConfiguration(styling: styling)
        let converter = MarkDownConverter(configuration: configuration)
        
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.dataDetectorTypes = .link
        textView.attributedText = converter.convert(markDownItems)
        textView.tintColor = styling.linkStyling.textColor
        textView.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0);
        
        return textView
    }
    
    func getMarkDownString() -> String {
        var markdownString:String = ""
        if let filepath = Bundle.main.path(forResource: "markdown", ofType: "txt") {
            markdownString = try! NSString(contentsOfFile: filepath, usedEncoding: nil) as String
        }
        
        return markdownString
    }
}
