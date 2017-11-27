//
//  TextAttachment.swift
//  Pods
//
//  Created by Jim van Zummeren on 20/06/16.
//
//

import Foundation
import UIKit

public class TextAttachment: NSTextAttachment {

    override public func attachmentBounds(for textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {

        var imageSize = CGSize()

        let originalImageSize = image?.size ?? CGSize()
        let imageRatio = originalImageSize.height / originalImageSize.width

        let desiredWidth = originalImageSize.height/imageRatio
        if desiredWidth > lineFrag.width {
            imageSize.width = lineFrag.width
            imageSize.height = imageSize.width * imageRatio
        } else {
            imageSize.height = originalImageSize.height
            imageSize.width = desiredWidth
        }

        return CGRect(origin: CGPoint(), size: imageSize)
    }
}
