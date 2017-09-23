//
//  Created by Jim van Zummeren on 09/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

/*
 * Label that allows tapping on links defined in the provided NSattributedString
 */

open class AttributedInteractiveLabel: UILabel {

    var linksAttributes: [(NSRange, URL?)] = []

    public init(){
        super.init(frame: CGRect())
        isUserInteractionEnabled = true;
        numberOfLines = 0
        addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(didTap(_:))));
    }


    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func setAttributedString(_ attributedString:NSAttributedString?) {
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

    @objc func didTap(_ tapGesture:UITapGestureRecognizer) {
        guard let view = tapGesture.view else { return }

        let locationInView = tapGesture.location(in: view)
        if let url = getUrlAtLocationInView(locationInView) {
            UIApplication.shared.openURL(url)
        }

    }

    //MARK: Private

    /**
     Tries to find a link attribute in the attributed text of the label at the given point

     - parameter locationInView: CGPoint where to look for a link attribute

     - returns: nil or the NSURL found at the given point
     */

    fileprivate func getUrlAtLocationInView(_ locationInView: CGPoint) -> URL?{
        guard let attributedText = attributedText else { return nil }

        var result: URL? = nil

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

    fileprivate func indexOfCharacterAtPoint(_ point: CGPoint, attributedString: NSAttributedString) -> Int {
        let textContainer = getTextContainer()
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: attributedString)
        textStorage.addLayoutManager(layoutManager)
        
        return layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
    }

    /**
     Creates a textContainer based on the current state of the label
     TextContainer's are used by NSLayoutManager

     - returns: NSTextContainer of the current view size
     */

    fileprivate func getTextContainer() -> NSTextContainer {

        /// Height should be any size that's at least bigger than the actual label size
        let height = frame.size.height + 100

        let textContainer = NSTextContainer(size: CGSize(width: frame.size.width , height: height))
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

    func extractLinkAttributes() -> [(NSRange, URL?)] {

        var result: [(NSRange, URL?)] = []

        if let attributedStringToEnumerate = self.mutableCopy() as? NSMutableAttributedString {

            attributedStringToEnumerate.enumerateAttribute(.link, in: attributedStringToEnumerate.fullRange(), options: []) {
                (value, range, stop) in

                self.removeAttribute(.link, range: range)
                result.append((range, value as? URL))
            }
        }
        
        return result
        
    }
}
