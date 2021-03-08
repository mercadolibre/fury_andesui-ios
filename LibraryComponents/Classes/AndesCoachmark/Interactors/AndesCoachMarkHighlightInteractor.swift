//
//  AndesCoachMarkHighlightInteractor.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 28/07/2020.
//

import Foundation

protocol AndesCoachMarkHighlightInteractorProtocol: class {
    func getHighlightRect() -> CGRect
    func getHighlightCornerRadius() -> CGFloat
    func getMaskPath() -> CGPath
    func isHighlightedViewBelow() -> Bool
    func update(view: UIView, style: AndesCoachMarkStepEntity.HighlightStyle, margin: CGFloat, insets: UIEdgeInsets)
}

class AndesCoachMarkHighlightInteractor {
    private var view: UIView
    private var style: AndesCoachMarkStepEntity.HighlightStyle
    private var margin: CGFloat
    private var insets: UIEdgeInsets
    private let overlayView: UIView
    private let bodyViewBounds: CGRect

    private var highlightedRect: CGRect { highlightedRectCalculation() }

    required init (overlayView: UIView, view: UIView, bodyViewBounds: CGRect, style: AndesCoachMarkStepEntity.HighlightStyle, margin: CGFloat = AndesCoachMarkConstants.Highlight.margin, insets: UIEdgeInsets = .zero) {
        self.overlayView = overlayView
        self.view = view
        self.bodyViewBounds = bodyViewBounds
        self.style = style
        self.margin = margin
        self.insets = insets
    }

    private func highlightedRectCalculation() -> CGRect {
        let margin = self.margin + 4
        var rectConverted = view.convert(view.bounds, to: overlayView)
        rectConverted = rectConverted.roundCGRect()
        // If the highlightRect dosen't fit in bodyView, it will be cutted
        // Horizontal excess
        let rectConvertedCuttedX = max(rectConverted.minX, margin)
        var rectConvertedCuttedWidth = rectConverted.width
        if rectConverted.minX < margin { rectConvertedCuttedWidth -= (margin - rectConverted.minX) }
        if rectConverted.maxX + margin > overlayView.bounds.width { rectConvertedCuttedWidth -= (margin + rectConverted.maxX - overlayView.bounds.width) }

        // Vertical excess
        if !isContainedVertically(rectConverted.insetBy(dx: 0, dy: -margin), in: bodyViewBounds) {
            return CGRect(x: rectConvertedCuttedX, y: rectConverted.minY, width: rectConvertedCuttedWidth, height: rectConverted.maxY - rectConverted.minY - margin)
        } else {
            return CGRect(x: rectConvertedCuttedX, y: rectConverted.origin.y, width: rectConvertedCuttedWidth, height: rectConverted.height)
        }
    }

    private func isContainedVertically(_ rect: CGRect, in container: CGRect) -> Bool {
        if rect.minY < container.minY || rect.maxY > container.maxY {
            return false
        }

        return true
    }

    private func buildSquareFrom(rect: CGRect, margin: CGFloat, insets: UIEdgeInsets) -> UIBezierPath {
        return UIBezierPath(roundedRect: rect.insetBy(dx: -margin, dy: -margin).inset(by: negateInsets(insets)),
                            cornerRadius: AndesCoachMarkConstants.Highlight.cornerRadius)
    }

    private func buildCircleFrom(rect: CGRect, margin: CGFloat, insets: UIEdgeInsets) -> UIBezierPath {
        let width = rect.width + margin + insets.left + insets.right
        return UIBezierPath(roundedRect: rect.insetBy(dx: -margin, dy: -margin).inset(by: negateInsets(insets)),
                            cornerRadius: width / 2)
    }

    private func negateInsets(_ insets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: -insets.top,
                            left: -insets.left,
                            bottom: -insets.bottom,
                            right: -insets.right)
    }

}

extension AndesCoachMarkHighlightInteractor: AndesCoachMarkHighlightInteractorProtocol {
    func update(view: UIView, style: AndesCoachMarkStepEntity.HighlightStyle, margin: CGFloat, insets: UIEdgeInsets) {
        self.view = view
        self.style = style
        self.margin = margin
        self.insets = insets
    }

    func getHighlightRect() -> CGRect {
        return highlightedRect.insetBy(dx: -margin, dy: -margin).inset(by: negateInsets(insets))
    }

    func getHighlightCornerRadius() -> CGFloat {
        let rect = getHighlightRect()
        switch style {
        case .rectangle:
            return AndesCoachMarkConstants.Highlight.cornerRadius
        case .circle:
            return (rect.width)/2
        }
    }

    func getMaskPath() -> CGPath {
        let path = UIBezierPath(rect: overlayView.bounds)
        var viewPath: UIBezierPath

        switch style {
        case .rectangle:
            viewPath = buildSquareFrom(rect: highlightedRect, margin: margin, insets: insets)
        case .circle:
            viewPath = buildCircleFrom(rect: highlightedRect, margin: margin, insets: insets)
        }

        path.append(viewPath)

        return path.cgPath
    }

    func isHighlightedViewBelow() -> Bool {
        return view.convert(view.frame, to: overlayView).midY > bodyViewBounds.midY
    }
}

extension CGRect {

    func round1000(_ double: CGFloat) -> Double {
        return Double(round(1000*double)/1000)
    }

    func roundCGRect() -> CGRect {
        return CGRect(x: round1000(self.minX), y: round1000(self.minY), width: round1000(self.width), height: round1000(self.height))
    }
}
