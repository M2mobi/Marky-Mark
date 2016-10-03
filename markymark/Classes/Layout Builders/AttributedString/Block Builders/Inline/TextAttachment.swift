//
//  TextAttachment.swift
//  Pods
//
//  Created by Jim van Zummeren on 20/06/16.
//
//

import Foundation
import UIKit

class TextAttachment: NSTextAttachment {
    
    override func attachmentBoundsForTextContainer(textContainer: NSTextContainer?, proposedLineFragment lineFrag: CGRect, glyphPosition position: CGPoint, characterIndex charIndex: Int) -> CGRect {
        
        var imageSize = CGSize()
        
        let originalImageSize = image?.size ?? CGSize()
        let imageRatio = originalImageSize.height / originalImageSize.width
        
        imageSize.width = lineFrag.width
        imageSize.height = imageSize.width * imageRatio
        
        return CGRect(origin: CGPoint(), size: imageSize)
    }
}
