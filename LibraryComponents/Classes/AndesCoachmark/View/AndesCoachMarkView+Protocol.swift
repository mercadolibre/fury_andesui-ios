//
//  AndesCoachMarkView+Protocol.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 03/08/2020.
//

// MARK: - Methods called from Presenter
extension AndesCoachMarkView: AndesCoachMarkViewProtocol {

    var bodyView: UIView? {
        return body
    }

    func setNavBar(_ title: String, shouldShowExitButton: Bool) {
        navBar.title = title
        navBar.showExitButton = shouldShowExitButton
        bringSubviewToFront(navBar)     // Workaround porque sino el overlay me afecta la vista
        layoutIfNeeded()
    }

    func setFooter() {
        bringSubviewToFront(footer)     // Workaround porque sino el overlay me afecta la vista
        layoutIfNeeded()
    }

    func setBody(_ presenter: AndesCoachMarkBodyPresenter, removePrevious: Bool) {
        if removePrevious { body?.removeFromSuperview() }
        body = AndesCoachMarkBodyView(presenter: presenter)
        body?.delegate = self

        guard let body = body else { return }
        body.alpha = 0
        addSubview(body)

        NSLayoutConstraint.activate([
            body.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            body.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            body.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            body.bottomAnchor.constraint(equalTo: footer.topAnchor)
        ])
        layoutIfNeeded()
        setupAccessibility()
    }

    func hideBody() {
        body?.hide()
    }

    func hide() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.navBar.alpha = 0
            self?.body?.alpha = 0
            self?.footer.alpha = 0
            self?.alpha = 0.5
        })
    }

    func exit(withCallback: Bool) {

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.alpha = 0
        }, completion: { [weak self] _ in
            if withCallback {
                self?.onExit?()
            }
            self?.removeFromSuperview()
        })

    }

    func show() {

        guard animated else {
            navBar.alpha = 1
            body?.alpha = 1
            footer.alpha = 1
            alpha = 1
            return
        }

        CATransaction.begin()

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.navBar.alpha = 1
            self?.body?.alpha = 1
            self?.footer.alpha = 1
            self?.alpha = 1
        })

        body?.show()

        CATransaction.commit()

    }

    func setHighlight(frame: CGRect, cornerRadius: CGFloat, maskPath: CGPath) {
        self.maskLayer.path = maskPath

        // I need this for covering the maskLayer so that the animation works.
        highlightedView?.hide()
        highlightedView = AndesCoachMarkHighlightedView(frame: frame, cornerRadius: cornerRadius, overlayColor: overlayColor, animated: animated)

        guard let highlightedView = highlightedView else { return }
        if let body = body, subviews.contains(body) {
            insertSubview(highlightedView, belowSubview: body)
        } else {
            addSubview(highlightedView)
        }

        highlightedView.show()
    }

    func removeHighlight() {
        highlightedView?.hide()
        self.maskLayer.path = UIBezierPath(rect: overlayLayer.bounds).cgPath
    }

    func showNext(stepIndex: Int) {
        delegate?.onShowNext(stepIndex: stepIndex)
    }

    func close(stepIndex: Int) {
        delegate?.onClose(stepIndex: stepIndex)
    }
}
