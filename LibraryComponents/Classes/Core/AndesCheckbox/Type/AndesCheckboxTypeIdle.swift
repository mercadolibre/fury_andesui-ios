//
//  AndesCheckboxTypeIdle.swift
//  AndesUI
//
//  Created by Rodrigo Pintos Costa on 6/16/20.
//

import Foundation
// Handle checkbox Idle type
class AndesCheckboxTypeIdle: AndesCheckboxTypeProtocol {
    var borderColor: UIColor?
    var borderSize: CGFloat?
    var textColor: UIColor = UIColor.Andes.gray800
    var backgroundColor: UIColor = UIColor.Andes.white
    var iconColor: UIColor? = UIColor.Andes.white
    var cornerRadius: CGFloat = 3

    init() {

    }

    init(status: AndesCheckboxStatus) {
        let statusProtocol = AndesCheckboxStatusFactory.provide(status)
        self.backgroundColor = statusProtocol.backgroundColor
        if status == AndesCheckboxStatus.unselected {
            self.borderColor = UIColor.Andes.gray250
            self.borderSize = 2
        }
    }
}
