//
//  AndesCoachMarkPresenter.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 16/04/2020.
//

import UIKit

class AndesCoachMarkPresenter {
    private(set) var model: AndesCoachMarkEntity
    weak var view: AndesCoachMarkViewProtocol?

    var animated = true

    private var currentIndex = -1

    private var currentStep: AndesCoachMarkStepEntity? {
        if currentIndex < 0 || model.steps.isEmpty { return nil }
        return model.steps[currentIndex]
    }

    private var scrollInteractor: AndesCoachMarkScrollInteractor?
    private var highlightInteractor: AndesCoachMarkHighlightInteractorProtocol?

    required init(model: AndesCoachMarkEntity, animated: Bool = true) {
        self.model = model
        self.animated = animated
    }

    private func createScrollInteractor() {
        guard let view = view,
            let scrollView = model.scrollView,
            let bodyView = view.bodyView else {
                scrollInteractor = nil
                return
        }
        scrollInteractor = AndesCoachMarkScrollInteractor(UIView(), scrollView: scrollView, bodyView: bodyView, animated: animated)

    }

    private func createHighlightInteractor() {
        guard let view = view,
            let bodyView = view.bodyView,
            let overlayView = bodyView.superview else {
                highlightInteractor = nil
                return
        }
        highlightInteractor = AndesCoachMarkHighlightInteractor(overlayView: overlayView, view: UIView(), bodyViewBounds: bodyView.convert(bodyView.bounds, to: overlayView), style: .rectangle)

    }

    private func restore(completion: (() -> Void)? = nil) {
        guard let scrollInteractor = scrollInteractor else {
            completion?()
            return
        }
        if scrollInteractor.restore(completion: completion) {
            view?.removeHighlight()
            hide()
        }
    }

    private func setBody(_ position: AndesCoachMarkBodyEntity.Position, removePrevious: Bool, buttonStyle: AndesCoachMarkBodyEntity.ButtonStyle) {
        guard let view = view, let currentStep = currentStep else { return }
        view.setBody(AndesCoachMarkBodyPresenter(model: AndesCoachMarkBodyEntity(title: currentStep.title,
                                                                           description: currentStep.descriptionText,
                                                                           viewToPoint: currentStep.view,
                                                                           position: position,
                                                                           nextText: currentStep.nextText,
                                                                           buttonStyle: buttonStyle)), removePrevious: removePrevious)
    }

    private func prepare() {
        guard let view = view, let currentStep = currentStep else { return }

        highlightInteractor?.update(view: currentStep.view, style: currentStep.style, margin: currentStep.margin, insets: currentStep.insets)
        let bodyPosition: AndesCoachMarkBodyEntity.Position = highlightInteractor?.isHighlightedViewBelow() ?? true ? .above : .below
        let buttonStyle: AndesCoachMarkBodyEntity.ButtonStyle = currentIndex+1 == model.steps.count ? .final : .normal

        view.setNavBar("\(currentIndex+1) de \(model.steps.count)", shouldShowExitButton: currentStep.showExitButton)
        view.setFooter()
        view.hideBody()
        setBody(bodyPosition, removePrevious: false, buttonStyle: buttonStyle)
        if let bodyView = view.bodyView {
            scrollInteractor?.update(highlightedView: currentStep.view, bodyView: bodyView)
        }

        // If it needs scroll, it will be performed
        if let scrollInteractor = scrollInteractor, scrollInteractor.isScrollNeeded() {
            view.removeHighlight()
            hide()
        } else {
            show()
            return
        }
        _ = scrollInteractor?.scrollIfNeeded { [weak self] in
            self?.setBody(bodyPosition, removePrevious: true, buttonStyle: buttonStyle)
            self?.show()
        }

    }

    private func showNext() {
        if currentIndex == model.steps.count - 1 {
            exit()
            return
        }

        self.currentIndex += 1
        prepare()
    }

    private func show() {
        guard let view = view, let currentStep = currentStep, let highlightInteractor = highlightInteractor else { return }

        highlightInteractor.update(view: currentStep.view, style: currentStep.style, margin: currentStep.margin, insets: currentStep.insets)

        view.setHighlight(frame: highlightInteractor.getHighlightRect(), cornerRadius: highlightInteractor.getHighlightCornerRadius(), maskPath: highlightInteractor.getMaskPath())
        view.show()
    }

    private func hide() {
        view?.hide()
    }

    private func exit(withCallback: Bool = true) {
        restore { [weak self] in
            self?.view?.exit(withCallback: withCallback)
        }
    }

    func start() {
        if currentIndex != -1 { return }

        currentIndex = 0
        setBody(.above, removePrevious: true, buttonStyle: .normal)
        createHighlightInteractor()
        createScrollInteractor()
        prepare()
    }

    func getWindow() -> UIWindow? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.last
    }

    func getStatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
}

// MARK: - Actions from view
extension AndesCoachMarkPresenter {

    func didNextActionTap() {
        view?.showNext(stepIndex: self.currentIndex)
        showNext()
    }

    func didCloseButtonTap() {
        view?.close(stepIndex: self.currentIndex)
        exit()
    }

    func didCancel() {
        view?.close(stepIndex: self.currentIndex)
        exit(withCallback: false)
    }

}
