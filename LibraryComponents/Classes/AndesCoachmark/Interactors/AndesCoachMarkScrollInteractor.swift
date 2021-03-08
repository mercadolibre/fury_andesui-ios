//
//  AndesCoachMarkScrollInteractor.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 24/04/2020.
//

import Foundation

class AndesCoachMarkScrollInteractor {

    private var highlightedView: UIView
    private var bodyView: UIView
    private let scrollView: UIScrollView
    private let margin: CGFloat
    private let animated: Bool

    private let contentOffset: CGPoint

    required init(_ highlightedView: UIView, scrollView: UIScrollView, bodyView: UIView, margin: CGFloat = 16, animated: Bool = true) {
        self.highlightedView = highlightedView
        self.scrollView = scrollView
        self.bodyView = bodyView
        self.margin = margin
        self.animated = animated

        // Keep this for restoring
        contentOffset = scrollView.contentOffset
    }

    func update(highlightedView: UIView, bodyView: UIView) {
        self.highlightedView = highlightedView
        self.bodyView = bodyView
    }

    func isScrollNeeded() -> Bool {
        guard let bodyViewContentSize = (bodyView.subviews.reduce(nil) { (rect, subview) -> CGRect in
            return (rect ?? subview.frame) + subview.frame
        }) else {
            return false
        }

        let highlightedViewConverted = highlightedView.convert(highlightedView.bounds, to: bodyView)

        let rect = bodyViewContentSize + highlightedViewConverted
        let rectWithMargin = CGRect(x: 0, y: rect.minY - (rect.isAbove(of: bodyView.bounds) ? margin : 0), width: 0, height: rect.height + (rect.isAbove(of: bodyView.bounds) || rect.isBelow(of: bodyView.bounds) ? margin : 0))

        // Make sure that the rect fit on body view. if it doesn't, it doesn't have scrolling!
        return !bodyView.bounds.contains(rectWithMargin) && (bodyView.bounds.height >= (bodyViewContentSize.height + highlightedViewConverted.height))
    }

    func scrollIfNeeded(completion: (() -> Void)? = nil) {
        // If coachmark is partially invisible at least, I need to scroll
        // If coachmark is visible and referenceview is uncompletely visible I need to scroll as much as posible without hiding the coachmark

        guard let bodyViewContentSize = (bodyView.subviews.reduce(nil) { (rect, subview) -> CGRect in
            return (rect ?? subview.frame) + subview.frame
        }) else {
            completion?()
            return
        }

        let highlightedViewConverted = highlightedView.convert(highlightedView.bounds, to: bodyView)

        let rect = bodyViewContentSize + highlightedViewConverted
        let rectWithMargin = CGRect(x: 0, y: rect.minY - (rect.isAbove(of: bodyView.bounds) ? margin : 0), width: 0, height: rect.height + (rect.isAbove(of: bodyView.bounds) || rect.isBelow(of: bodyView.bounds) ? margin : 0))

        if !bodyView.bounds.contains(rectWithMargin) && !scrollView.bounds.contains(highlightedView.frame) {
            let newOffset: CGPoint
            let bodyViewConvertedToScrollViewOrigin = bodyView.convert(bodyView.bounds, to: scrollView)

            if rectWithMargin.isAbove(of: bodyView.bounds) {
                newOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + bodyViewConvertedToScrollViewOrigin.minY + rectWithMargin.minY - bodyViewConvertedToScrollViewOrigin.minY)
            } else {
                newOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + bodyViewConvertedToScrollViewOrigin.minY + rectWithMargin.maxY - bodyViewConvertedToScrollViewOrigin.maxY)
            }

            if animated {
                UIView.animate(
                    withDuration: 1,
                    animations: { [weak self] in
                        guard let self = self else { return }
                        self.scrollView.contentOffset = newOffset
                    },
                    completion: { _ in
                        completion?()
                    }
                )
            } else {
                self.scrollView.contentOffset = newOffset
                completion?()
            }

            return
        }

        // Otherwise I don't need to scroll
        completion?()
        return
    }

    func restore(completion: (() -> Void)? = nil) -> Bool {
        guard scrollView.contentOffset != contentOffset else {
            completion?()
            return false
        }

        if animated {
            UIView.animate(
                withDuration: 1,
                animations: { [weak self] in
                    guard let self = self else { return }
                    self.scrollView.contentOffset = self.contentOffset
                },
                completion: { _ in
                    completion?()
                }
            )
        } else {
            scrollView.contentOffset = contentOffset
            completion?()
        }

        return true
    }

}

extension CGRect {
    static func +(lhs: CGRect, rhs: CGRect) -> CGRect {
        let minX = min(lhs.minX, rhs.minX)
        let minY = min(lhs.minY, rhs.minY)

        return CGRect(x: minX,
                      y: minY,
                      width: abs(max(lhs.maxX, rhs.maxX) - minX),
                      height: abs(max(lhs.maxY, rhs.maxY) - minY))
    }

    func isAbove(of rect: CGRect) -> Bool {
        return self.minY < rect.minY
    }

    func isBelow(of rect: CGRect) -> Bool {
        return self.maxY > rect.maxY
    }
}
