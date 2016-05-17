//
//  Created by Jim van Zummeren on 09/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

/*
 * Label that allows tapping on links defined in the provided NSattributedString
 */

class AttributedInteractiveLabel: UILabel {

    var linksAttributes:[(NSRange, NSURL?)] = []

    init(){
        super.init(frame: CGRectZero)
        userInteractionEnabled = true;
        numberOfLines = 0
        addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(didTap(_:))));
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setAttributedString(attributedString:NSAttributedString?) {
        guard let attributedString = attributedString else {
            self.attributedText = nil
            return
        }

        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)

        /// Extract link attributes from the attributed string and store them
        /// Needed because UILabel automatically makes all link attributes blue
        linksAttributes = mutableAttributedString.extractLinkAttributes()

        self.attributedText = mutableAttributedString
    }

    func didTap(tapGesture:UITapGestureRecognizer) {
        guard let view = tapGesture.view else { return }

        let locationInView = tapGesture.locationInView(view)
        if let url = getUrlAtLocationInView(locationInView) {
            UIApplication.sharedApplication().openURL(url)
        }

    }

    //MARK: Private

    /**
     Tries to find a link attribute in the attributed text of the label at the given point

     - parameter locationInView: CGPoint where to look for a link attribute

     - returns: nil or the NSURL found at the given point
     */

    private func getUrlAtLocationInView(locationInView:CGPoint) -> NSURL?{
        guard let attributedText = attributedText else { return nil }

        var result:NSURL? = nil

        let indexOfCharacter = indexOfCharacterAtPoint(locationInView, attributedString: attributedText)

        for (range, url) in linksAttributes {

            if NSLocationInRange(indexOfCharacter, range) {
                result = url
            }
        }

        return result
    }

    /**
     Uses a textcontainer to determine what character is at the given CGPoint

     - parameter point:            Any CGPoint, most likely a touchpoint on the view
     - parameter attributedString: Attributed string to find a character in

     - returns: The index of the character that was found at the given point
     */

    private func indexOfCharacterAtPoint(point:CGPoint, attributedString:NSAttributedString) -> Int {
        let textContainer = getTextContainer()
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: attributedString)
        textStorage.addLayoutManager(layoutManager)
        
        return layoutManager.characterIndexForPoint(point, inTextContainer: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
    }

    /**
     Creates a textContainer based on the current state of the label
     TextContainer's are used by NSLayoutManager

     - returns: NSTextContainer of the current view size
     */

    private func getTextContainer() -> NSTextContainer {
        let textContainer = NSTextContainer(size: CGSize(width: frame.size.width , height: frame.size.height))
        textContainer.lineFragmentPadding = 0.0;
        textContainer.lineBreakMode = lineBreakMode;
        textContainer.maximumNumberOfLines = numberOfLines;

        return textContainer
    }
}

private extension NSMutableAttributedString {

    /**
     Removes all NSLinkAttributeName from the AttributedString

     - returns: Array of all removed attributes as Range & URL pairs
     */

    func extractLinkAttributes() -> [(NSRange, NSURL?)] {

        var result:[(NSRange, NSURL?)] = []

        if let attributedStringToEnumerate = self.mutableCopy() as? NSMutableAttributedString {

            attributedStringToEnumerate.enumerateAttribute(NSLinkAttributeName, inRange: attributedStringToEnumerate.fullRange(), options: []) {
                (value, range, stop) in

                self.removeAttribute(NSLinkAttributeName, range: range)
                result.append((range, value as? NSURL))
            }
        }
        
        return result
        
    }
}
