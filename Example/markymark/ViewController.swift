//
//  Created by Jim van Zummeren on 22/04/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import UIKit
import MarkyMark

class ViewController: UIViewController {

    override func viewDidLoad() {

        self.view = UIScrollView()

        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .redColor()
        button.addTarget(self, action:#selector(didTap), forControlEvents: .TouchUpInside)
        view.addSubview(button)

        super.viewDidLoad()
    }

    func didTap() {
        measure {
            [unowned self] in
            let markyMark = MarkyMark(build: {
                $0.setFlavor(ContentfulFlavor())
            })

            var markdown:String = ""
            if let filepath = NSBundle.mainBundle().pathForResource("markdown", ofType: "txt") {
                markdown = try! NSString(contentsOfFile: filepath, usedEncoding: nil) as String
            }

            let markDownItems = markyMark.parseMarkDown(markdown)

            var styling = DefaultStyling()
            styling.linkStyling.textColor = .redColor()

            let converter = MarkDownConverter(configuration: MarkdownToViewConverterConfiguration(styling : styling))

            let markDownView = converter.convert(markDownItems)
            self.view.addSubview(markDownView)

            let views = [
                "view" : self.view,
                "markDownView" : markDownView
            ]

            markDownView.translatesAutoresizingMaskIntoConstraints = false

            var constraints:[NSLayoutConstraint] = []
            constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[markDownView(==view)]|", options: [], metrics: [:], views: views)
            constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[markDownView]|", options: [], metrics: [:], views: views)
            self.view.addConstraints(constraints)
        }
    }

    func measure(completion: () -> Void) {
        let startDate: NSDate = NSDate()
        completion()
        let endDate: NSDate = NSDate()
        let timeInterval: Double = endDate.timeIntervalSinceDate(startDate)
        print("seconds: \(timeInterval)")
    }
}