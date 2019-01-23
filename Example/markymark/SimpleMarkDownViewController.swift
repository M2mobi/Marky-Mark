//
//  Created by Jim van Zummeren on 22/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit
import markymark

class SimpleMarkDownViewController: UIViewController {
    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
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

private extension SimpleMarkDownViewController {

    func getMarkDownView() -> UIView {
        let markDownView = MarkDownTextView(markDownConfiguration: .view)

        //Styling. See README for more styling options
        markDownView.styling.headingStyling.textColorsForLevels = [.orange, .black]
        markDownView.styling.linkStyling.textColor = .blue
        markDownView.styling.listStyling.bulletImages = [
            UIImage(named: "circle"),
            UIImage(named: "emptyCircle"),
            UIImage(named: "line"),
            UIImage(named: "square")
        ]

        markDownView.styling.paragraphStyling.baseFont = .systemFont(ofSize: 14)

        markDownView.text = getMarkDownString()
        return markDownView
    }

    func getMarkDownString() -> String {
        var markdownString: String = ""
        if let filepath = Bundle.main.path(forResource: "markdown", ofType: "txt") {
            markdownString = try! String(contentsOfFile: filepath)
        }

        return markdownString
    }
}
