//
//  AndesRadioButtonAlign.swift
//  AndesUI
//
//  Created by Rodrigo Pintos Costa on 6/30/20.
//

import Foundation
// Used to set the radioButton align
@objc public enum AndesRadioButtonAlign: Int, AndesEnumStringConvertible {
    case left
    case right

    public static func keyFor(_ value: AndesRadioButtonAlign) -> String {
        switch value {
        case .left: return "LEFT"
        case .right: return "RIGHT"
        }
    }
}
