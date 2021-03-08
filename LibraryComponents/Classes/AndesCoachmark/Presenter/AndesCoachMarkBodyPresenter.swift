//
//  AndesCoachMarkBodyPresenter.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 22/07/2020.
//

import Foundation

class AndesCoachMarkBodyPresenter {
    private var firstLayout = true
    private let model: AndesCoachMarkBodyEntity
    weak var view: AndesCoachMarkBodyViewProtocol?

    required init(model: AndesCoachMarkBodyEntity) {
        self.model = model
    }

    func viewLaidOut() {
        // I want to do this once
        if !firstLayout { return }
        firstLayout = false

        view?.setupTitleLabel(title: model.title)
        view?.setupDescriptionLabel(description: model.description)
        view?.setupNextButton(nextText: model.nextText, buttonStyle: model.buttonStyle)

        drawArrow()
    }

    private func drawArrow() {
        guard let view = view else { return }

        let rectToPoint = view.convertCoordinates(view: model.viewToPoint)
        let isRight = rectToPoint.midX > view.width/2
        let width = abs(view.width/2 - rectToPoint.midX)

        if width < AndesCoachMarkArrowView.getMinWidth() {
            noDrawArrow()
            return
        }

        switch model.position {
        case .below:
            if isRight {
                view.setupArrowAboveOfTextAndPointToRight(positionY: rectToPoint.maxY + 28, width: width)
            } else {
                view.setupArrowAboveOfTextAndPointToLeft(positionY: rectToPoint.maxY + 28, width: width)
            }
        case .above:
            if isRight {
                view.setupArrowBelowOfTextAndPointToRight(positionY: rectToPoint.minY - 28, width: width)
            } else {
                view.setupArrowBelowOfTextAndPointToLeft(positionY: rectToPoint.minY - 28, width: width)
            }
        case .none:
            break
        }
    }

    private func noDrawArrow() {
        guard let view = view else { return }

        let rectToPoint = view.convertCoordinates(view: model.viewToPoint)

        switch model.position {
        case .above:
            view.setupTextAbove(of: rectToPoint.minY - 24)
        case .below:
            view.setupTextBelow(of: rectToPoint.maxY + 20)
        case .none:
            break
        }
    }
}
