//
//  BottomSheetExampleScrollableContentViewController.swift
//  AndesUI-demoapp
//
//  Created by Tomi De Lucca on 03/11/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import AndesUI

class BottomSheetExampleScrollableContentViewController: UIViewController {
    private let rainbow = [UIColor(red: 0.873, green: 0.001, blue: 0.000, alpha: 1.00),
                           UIColor(red: 0.998, green: 0.386, blue: 0.176, alpha: 1.00),
                           UIColor(red: 0.998, green: 0.968, blue: 0.000, alpha: 1.00),
                           UIColor(red: 0.002, green: 0.741, blue: 0.004, alpha: 1.00),
                           UIColor(red: 0.001, green: 0.615, blue: 0.997, alpha: 1.00),
                           UIColor(red: 0.000, green: 0.000, blue: 0.519, alpha: 1.00),
                           UIColor(red: 0.247, green: 0.000, blue: 1.000, alpha: 1.00)]

    private let rowHeight: CGFloat

    init(rowHeight: CGFloat) {
        self.rowHeight = rowHeight
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BottomSheetExampleScrollableContent"
        view.backgroundColor = rainbow.last!

        let scrollView = buildRainbowView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func buildRainbowView() -> UIScrollView {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill

        let scrollView = UIScrollView()
        scrollView.addSubview(stackView)

        for color in rainbow {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = color
            view.heightAnchor.constraint(equalToConstant: rowHeight).isActive = true
            stackView.addArrangedSubview(view)
        }

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        return scrollView
    }
}
