//
//  AndesListSimpleViewCell.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 20/10/20.
//

import UIKit

class AndesListSimpleViewCell: AndesListViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var paddingLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var paddingRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var paddingTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var paddingBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var separatorHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!

    internal func display(indexPath: IndexPath, customCell: AndesListViewCell, separatorStyle: AndesSeparatorStyle) {
        self.titleLbl.text = customCell.title
        self.titleLbl.setAndesStyle(style: customCell.fontStyle)
        self.titleLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: customCell.titleHeight).isActive = true
        self.subTitleLbl.text = customCell.subTitle
        self.subTitleLbl.setAndesStyle(style: customCell.fontSubTitleStyle)
        self.subTitleLbl.heightAnchor.constraint(equalToConstant: customCell.subTitleHeight).isActive = true
        self.paddingLeftConstraint.constant = customCell.paddingLeftCell
        self.paddingRightConstraint.constant = customCell.paddingRightCell
        self.paddingTopConstraint.constant = customCell.paddingTopCell
        self.paddingBottomConstraint.constant = customCell.paddingBottomCell
        self.separatorHeightConstraint.constant = customCell.separatorHeight
        if let imageSize = customCell.thumbnailSize {
            self.thumbnailWidthConstraint.constant = imageSize
            self.thumbnailHeightConstraint.constant = imageSize
            self.paddingTopThumbnailConstraint.constant = customCell.paddingTopThumbnail ?? 0
            self.paddingBottomThumbnailConstraint.constant = customCell.paddingBottomThumbnail ?? 0
            self.thumbnailImg.image = customCell.thumbnailLeft
            self.spaceThumbnailWidthConstraint.constant = customCell.separatorThumbnailWidth ?? 0
        }
        setupSeparatorStyle(separatorStyle: separatorStyle)
    }

    func setupSeparatorStyle(separatorStyle: AndesSeparatorStyle) {
        switch separatorStyle {
        case .none:
            separatorView.backgroundColor = .clear
        case .singleLine:
            separatorView.backgroundColor = UIColor.Andes.gray100
        }

    }
}
