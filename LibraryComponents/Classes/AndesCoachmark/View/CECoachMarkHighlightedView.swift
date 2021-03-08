//
//  AndesCoachMarkHighlightedView.swift
//  CardsEngagement
//
//  Created by JONATHAN DANIEL BANDONI on 30/07/2020.
//

class AndesCoachMarkHighlightedView: UIView {
    var animated: Bool

    private lazy var strokeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = strokeView.bounds
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = AndesStyleSheetManager.styleSheet.accentColor.cgColor
        layer.lineWidth = AndesCoachMarkConstants.Highlight.borderWidth
        strokeView.layer.addSublayer(layer)
        return layer
    }()

    private lazy var strokeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.backgroundColor = .clear
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        return view
    }()

    private lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return view
    }()

    required init (frame: CGRect, cornerRadius: CGFloat, overlayColor: UIColor, animated: Bool = true) {
        self.animated = animated
        super.init(frame: frame)

        strokeLayer.path = UIBezierPath(roundedRect: bounds.insetBy(dx: -AndesCoachMarkConstants.Highlight.borderMargin, dy: -AndesCoachMarkConstants.Highlight.borderMargin), cornerRadius: cornerRadius).cgPath
        overlayView.backgroundColor = overlayColor
        overlayView.layer.cornerRadius = cornerRadius
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

extension AndesCoachMarkHighlightedView {
    func show() {
        guard animated else {
            strokeView.alpha = 1
            overlayView.alpha = 0
            return
        }

        UIView.animate(withDuration: AndesCoachMarkConstants.Animation.duration, delay: AndesCoachMarkConstants.Animation.delay, options: .curveEaseOut, animations: { [weak self] in
            self?.strokeView.alpha = 1
            self?.overlayView.alpha = 0
        })
    }

    func hide() {
        // This is not animated because of simplicity!
        removeFromSuperview()
    }
}
