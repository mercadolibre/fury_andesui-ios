//
//  AndesTextfieldCodeThreeByThree.swift
//  AndesUI
//
//  Created by Esteban Adrian Boffa on 18/09/2020.
//

import Foundation

final class AndesTextfieldCodeThreeByThree: AndesTextfieldCodeAbstractView {

    override internal func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesTextfieldCodeThreeByThree", owner: self, options: nil)
    }
}
