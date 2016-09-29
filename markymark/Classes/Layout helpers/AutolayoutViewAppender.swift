//
// Created by Jim van Zummeren on 28/01/15.
//

import UIKit

class AutoLayoutViewAppender {

    let container: UIView
    var previousView: UIView?

    var views: [UIView] = []
    var constraints: [NSLayoutConstraint] = []


    init(container: UIView) {
        self.container = container
        self.container.translatesAutoresizingMaskIntoConstraints = false
    }

    func appendView(_ view:UIView, verticalMargin:CGFloat, horizontalMargin:CGFloat) {
        container.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        let metrics = [
                "verticalMargin" : verticalMargin,
                "horizontalMargin" : horizontalMargin,
        ]

        var views = [ "view" : view ]
        var constraints:[NSLayoutConstraint] = []

        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-(horizontalMargin)-[view]|", options: [], metrics: metrics, views: views)

        if let previousView = previousView {
            views["previousView"] = previousView
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[previousView]-(verticalMargin)-[view]", options: [], metrics: metrics, views: views)
        } else {
            constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(verticalMargin)-[view]", options: [], metrics: metrics, views: views)
        }

        container.addConstraints(constraints)
        self.views.append(view)

        self.constraints += constraints
        self.previousView = view
    }

    func finishAppendingWithPadding(_ verticalMargin:CGFloat) {
        guard let previousView = previousView else { return }

        let views = [ "view" : previousView ]

        let metrics = [
           "verticalMargin" : verticalMargin
        ]

        let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-(verticalMargin)-|", options: [], metrics: metrics, views: views)

        self.container.addConstraints(constraints)
        self.constraints += constraints
    }

    func removeConstraints() {
        self.previousView = nil
        self.container.removeConstraints(self.constraints)
        self.constraints = []
    }
};
