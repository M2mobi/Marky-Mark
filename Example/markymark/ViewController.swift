//
//  Created by Jim van Zummeren on 22/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit
import MarkyMark

class ViewController: UIViewController {

    override func viewDidLoad() {

        self.view = UIScrollView()

        let markyMark = MarkyMark(build: {
            $0.setFlavor(ContentfulFlavor())
        })

        var markdown:String = ""
        if let filepath = NSBundle.mainBundle().pathForResource("markdown", ofType: "txt") {
            markdown = try! NSString(contentsOfFile: filepath, usedEncoding: nil) as String
        }
        for _ in 0...10 {
            measure {
                let _ = markyMark.parseMarkDown(markdown)
            }
        }

        let markDownItems = markyMark.parseMarkDown(markdown)

        var styling = DefaultStyling()
        styling.linkStyling.textColor = .redColor()

        let markDownView = MarkDownConverter(configuration: MarkdownToViewConverterConfiguration(styling : styling)).convert(markDownItems)
        view.addSubview(markDownView)

        let views = [
            "view" : view,
            "markDownView" : markDownView,
            ]

        markDownView.translatesAutoresizingMaskIntoConstraints = false

        var constraints:[NSLayoutConstraint] = []
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[markDownView(==view)]|", options: [], metrics: [:], views: views)
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|[markDownView]|", options: [], metrics: [:], views: views)
        view.addConstraints(constraints)
        
        super.viewDidLoad()
    }
}

func measure(completion: () -> ()) {
    let startDate: NSDate = NSDate()
    completion()
    let endDate: NSDate = NSDate()
    let timeInterval: Double = endDate.timeIntervalSinceDate(startDate)
    print("seconds: \(timeInterval)")
}