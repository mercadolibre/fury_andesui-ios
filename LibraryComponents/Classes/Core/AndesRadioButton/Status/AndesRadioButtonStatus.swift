//
//  AndesRadioButtonStatus.swift
//  AndesUI
//
//  Created by Rodrigo Pintos Costa on 6/30/20.
//

import Foundation
// Used to set the radiobutton status
@objc public enum AndesRadioButtonStatus: Int, AndesEnumStringConvertible {
    case selected
    case unselected

    public static func keyFor(_ value: AndesRadioButtonStatus) -> String {
        switch value {
        case .selected: return "SELECTED"
        case .unselected: return "UNSELECTED"
        }
    }
}
