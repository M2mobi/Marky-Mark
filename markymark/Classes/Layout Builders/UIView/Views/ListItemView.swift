//
//  Created by Jim van Zummeren on 06/05/16.
//  Copyright © 2016 M2mobi. All rights reserved.
//

import Foundation
import UIKit

class ListItemView: UIView {

    var bottomSpace: CGFloat = 0

    /// List Mark down item to display
    let listMarkDownItem: ListMarkDownItem

    /// Label to display the content of the top level list item
    var label: AttributedInteractiveLabel = AttributedInteractiveLabel()

    /// bullet view to display the bullet character •, 1. or a. for example(
    var bullet: UIView?

    var styling: BulletStylingRule?

    private let renderContext: RenderContext?

    init(
        listMarkDownItem: ListMarkDownItem,
        styling: BulletStylingRule?,
        attributedText: NSAttributedString,
        renderContext: RenderContext? = nil
    ) {
        self.listMarkDownItem = listMarkDownItem
        self.styling = styling
        self.renderContext = renderContext

        super.init(frame: CGRect())

        label.markDownAttributedString = attributedText
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = renderContext?.hasScalableFonts ?? false

        if let urlOpener = renderContext?.urlOpener {
            label.urlOpener = urlOpener
        }

        setUpLayout()
    }

    override func layoutSubviews() {

        label.sizeToFit()

        if let bulletSize = getScaledBulletSize() {
            label.frame.size.width = frame.size.width - bulletSize.width
            label.frame.origin.x = bulletSize.width
            bullet?.frame = CGRect(x: 0, y: 0, width: bulletSize.width, height: bulletSize.height)
        } else {
            label.frame.size.width = frame.size.width
        }

        super.layoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getScaledBulletSize() -> CGSize? {
        guard let styling = styling else { return nil }
        let hasScalableFonts = renderContext?.hasScalableFonts == true

        if
            hasScalableFonts,
            let originalPointSize = styling.neededBaseFont()?.pointSize,
            let newPointSize = styling.neededFont(hasScalableFonts: hasScalableFonts)?.pointSize
        {
            let scaleFactor = newPointSize / originalPointSize

            return .init(
                width: styling.bulletViewSize.width * scaleFactor,
                height: styling.bulletViewSize.height * scaleFactor
            )
        } else {
            return styling.bulletViewSize
        }
    }

    // MARK: Private

    /**
     Set up layout for list item with either an image or text as bullet
     */

    private func setUpLayout() {
        bullet = getBulletView()
        if let bullet = bullet {

            addSubview(label)
            addSubview(bullet)
        }
    }

    private func getBulletView() -> UIView {
        let bulletLabel = UILabel()

        if let indexCharacter = listMarkDownItem.indexCharacter {
            bulletLabel.text = "\(indexCharacter)"
        } else if let styling = styling, (styling.bulletImages == nil || styling.bulletImages?.count == 0) {
            bulletLabel.text = "•"
        } else {
            return getImageBulletView()
        }

        if let styling = styling {

            if let font = styling.bulletFont {
                if renderContext?.hasScalableFonts == true, let textStyle = styling.neededTextStyle() {
                    bulletLabel.font = font.scaledFont(
                        textStyle: textStyle,
                        maximumPointSize: styling.neededMaximumPointSize()
                    )
                } else {
                    bulletLabel.font = font
                }
            }

            if let color = styling.bulletColor {
                bulletLabel.textColor = color
            }

            return bulletLabel
        }

        return UIView()
    }

    private func getImageBulletView() -> UIView {
        guard let styling = styling, let images = styling.bulletImages, images.count > 0 else { return UIView() }

        let imageIndex = listMarkDownItem.level % images.count

        let bulletImageView = UIImageView(image: images[imageIndex])
        bulletImageView.contentMode = .center
        return bulletImageView

    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: self.label.frame.size.height + bottomSpace)
    }

}
