//
//  AndesCoachMarkViewProtocol.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 04/06/2020.
//

protocol AndesCoachMarkViewProtocol: class {
    // Properties
    var bodyView: UIView? { get }

    // Behaviour
    func show()
    func hide()
    func setHighlight(frame: CGRect, cornerRadius: CGFloat, maskPath: CGPath)
    func removeHighlight()

    func setNavBar(_ title: String, shouldShowExitButton: Bool)
    func setBody(_ presenter: AndesCoachMarkBodyPresenter, removePrevious: Bool)
    func hideBody()
    func setFooter()

    // Delegate
    func showNext(stepIndex: Int)
    func close(stepIndex: Int)
    func exit(withCallback: Bool)
}
