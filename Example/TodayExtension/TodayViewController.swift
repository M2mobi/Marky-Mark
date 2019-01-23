//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Jim van Zummeren on 21/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import NotificationCenter
import markymark

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBOutlet var markDownTextView: MarkDownTextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        markDownTextView?.text = """
        # Some header
        A paragraph with a **link** to [Google](https://www.google.com)

        """

        markDownTextView?.urlOpener = ExtensionContextURLOpener(extensionContext: self.extensionContext)
    }
}
