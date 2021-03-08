//
//  AndesStyleSheetDefault.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 04/12/2019.
//

import Foundation

@objc public class AndesStyleSheetDefault: NSObject, AndesStyleSheet {

    private var stylesheetStrategy: AndesColors

    public lazy var bgColorPrimary: UIColor = self.stylesheetStrategy.bgColorPrimary
    public lazy var bgColorSecondary: UIColor = self.stylesheetStrategy.bgColorSecondary
    public lazy var bgColorWhite: UIColor = self.stylesheetStrategy.bgColorWhite

    public lazy var brandColor500: UIColor = self.stylesheetStrategy.brandColor500

    public lazy var accentColor: UIColor = self.stylesheetStrategy.accentColor
    public lazy var accentColor100: UIColor = self.stylesheetStrategy.accentColor100
    public lazy var accentColor150: UIColor = self.stylesheetStrategy.accentColor150
    public lazy var accentColor200: UIColor = self.stylesheetStrategy.accentColor200
    public lazy var accentColor300: UIColor = self.stylesheetStrategy.accentColor300
    public lazy var accentColor400: UIColor = self.stylesheetStrategy.accentColor400
    public lazy var accentColor500: UIColor = self.stylesheetStrategy.accentColor500
    public lazy var accentColor600: UIColor = self.stylesheetStrategy.accentColor600
    public lazy var accentColor700: UIColor = self.stylesheetStrategy.accentColor700
    public lazy var accentColor800: UIColor = self.stylesheetStrategy.accentColor800

    public lazy var textColorPrimary: UIColor = self.stylesheetStrategy.textColorPrimary
    public lazy var textColorSecondary: UIColor = self.stylesheetStrategy.textColorSecondary
    public lazy var textColorDisabled: UIColor = self.stylesheetStrategy.textColorDisabled
    public lazy var textColorNegative: UIColor = self.stylesheetStrategy.textColorNegative
    public lazy var textColorCaution: UIColor = self.stylesheetStrategy.textColorCaution
    public lazy var textColorPositive: UIColor = self.stylesheetStrategy.textColorPositive
    public lazy var tetColorLink: UIColor = self.stylesheetStrategy.tetColorLink
    public lazy var textColorLink: UIColor = self.stylesheetStrategy.textColorLink
    public lazy var textColorWhite: UIColor = self.stylesheetStrategy.textColorWhite
    public lazy var textColorWarning: UIColor = self.stylesheetStrategy.textColorWarning

    public lazy var feedbackColorCaution: UIColor = self.stylesheetStrategy.feedbackColorCaution
    public lazy var feedbackColorPositive: UIColor = self.stylesheetStrategy.feedbackColorPositive
    public lazy var feedbackColorNegative: UIColor = self.stylesheetStrategy.feedbackColorNegative
    public lazy var feedbackColorWarning: UIColor = self.stylesheetStrategy.feedbackColorWarning

    public override init() {
        // TODO: Remove when iOS 11 is minimum deployment target, use ios 11 strat when new build system issues are solved
        self.stylesheetStrategy = AndesColorStrategyiOS10()
    }

    public func titleXL(color: UIColor) -> AndesFontStyle {
        validateColorForTitle(color: color)
        return AndesFontStyle(textColor: color, font: semiboldSystemFontOfSize(size: AndesFontSize.titleXL), lineSpacing: 1.25)
    }

    public func titleL(color: UIColor) -> AndesFontStyle {
        validateColorForTitle(color: color)
        return AndesFontStyle(textColor: color, font: semiboldSystemFontOfSize(size: AndesFontSize.titleL), lineSpacing: 1.25)
    }

    public func titleM(color: UIColor) -> AndesFontStyle {
        validateColorForTitle(color: color)
        return AndesFontStyle(textColor: color, font: semiboldSystemFontOfSize(size: AndesFontSize.titleM), lineSpacing: 1.25)
    }

    public func titleS(color: UIColor) -> AndesFontStyle {
        validateColorForTitle(color: color)
        return AndesFontStyle(textColor: color, font: semiboldSystemFontOfSize(size: AndesFontSize.titleS), lineSpacing: 1.25)
    }

    public func titleXS(color: UIColor) -> AndesFontStyle {
        validateColorForTitle(color: color)
        return AndesFontStyle(textColor: color, font: semiboldSystemFontOfSize(size: AndesFontSize.titleXS), lineSpacing: 1.25)
    }

    public func bodyL(color: UIColor) -> AndesFontStyle {
        validateColorForBody(color: color)
        return AndesFontStyle(textColor: color, font: regularSystemFont(size: AndesFontSize.bodyL), lineSpacing: 1.25)
    }

    public func bodyM(color: UIColor) -> AndesFontStyle {
        validateColorForBody(color: color)
        return AndesFontStyle(textColor: color, font: regularSystemFont(size: AndesFontSize.bodyM), lineSpacing: 1.25)
    }

    public func bodyS(color: UIColor) -> AndesFontStyle {
        validateColorForBody(color: color)
        return AndesFontStyle(textColor: color, font: regularSystemFont(size: AndesFontSize.bodyS), lineSpacing: 1.25)
    }

    public func bodyXS(color: UIColor) -> AndesFontStyle {
        validateColorForBody(color: color)
        return AndesFontStyle(textColor: color, font: regularSystemFont(size: AndesFontSize.bodyXS), lineSpacing: 1.25)
    }

    public func regularSystemFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public func lightSystemFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public func mediumSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    public func semiboldSystemFontOfSize(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }

    private func validateColorForTitle(color: UIColor) {
        if !color.isEqual(self.stylesheetStrategy.textColorWhite) && !color.isEqual(self.stylesheetStrategy.textColorPrimary) {
            fatalError("You must use an allowed color. Please check Andes documentation")
        }
    }

    private func validateColorForBody(color: UIColor) {
        if !color.isEqual(self.stylesheetStrategy.textColorPrimary) && !color.isEqual(self.stylesheetStrategy.textColorSecondary) &&
            !color.isEqual(self.stylesheetStrategy.textColorWhite) &&
            !color.isEqual(self.stylesheetStrategy.textColorDisabled) {
            fatalError("You must use an allowed color. Please check Andes documentation")
        }
    }

    private func validateColorForLink(color: UIColor) {
        if !color.isEqual(self.stylesheetStrategy.textColorLink) {
            fatalError("You must use an allowed color. Please check Andes documentation")
        }
    }
}
