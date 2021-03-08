//
//  BottomSheetSwiftExampleViewController.swift
//  AndesUI-demoapp
//
//  Created by Tomi De Lucca on 29/10/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import AndesUI

private enum Size: Int {
    case small = 0
    case medium
    case large

    func toConcreteSize() -> CGFloat {
        switch self {
        case .small:
            return 40
        case .medium:
            return 90
        case .large:
            return 200
        }
    }
}

private struct Configuration {
    var titleEnabled: Bool = true
    var size: Size = .medium
    var presentationStyle: AndesBottomSheetPresentationStyle = .fixed
}

class BottomSheetSwiftExampleViewController: UIViewController {

    private var configuration = Configuration()

    private let contentView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BottomSheetSwiftExampleViewController"
        view.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        contentView.addArrangedSubview(buildTitleEnabledRow())
        contentView.addArrangedSubview(buildSizePickerRow())
        contentView.addArrangedSubview(buildPresentationSizePickerRow())
        contentView.addArrangedSubview(buildOpenSheetButtonRow())

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16.0),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0)
        ])
    }

    private func buildTitleEnabledRow() -> UIView {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 16.0

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Show title"
        label.textColor = UIColor.Andes.gray800
        label.font = AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: AndesFontSize.bodyM)

        let toggle = UISwitch()
        toggle.onTintColor = UIColor.Andes.blueMP500
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.setOn(configuration.titleEnabled, animated: false)
        toggle.addTarget(self, action: #selector(titleEnabledDidChange), for: .valueChanged)

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(toggle)

        return stackView
    }

    private func buildSizePickerRow() -> UIView {
        let segmentedControl = UISegmentedControl(items: ["Small", "Medium", "Large"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = configuration.size.rawValue
        segmentedControl.addTarget(self, action: #selector(sizePickerDidChange), for: .valueChanged)
        return segmentedControl
    }

    private func buildPresentationSizePickerRow() -> UIView {
        let segmentedControl = UISegmentedControl(items: ["fixed", "intrinsic"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = configuration.presentationStyle.rawValue
        segmentedControl.addTarget(self, action: #selector(presentationSizePickerDidChange), for: .valueChanged)
        return segmentedControl
    }

    private func buildOpenSheetButtonRow() -> UIView {
        let button = AndesButton(text: "Open Sheet", hierarchy: .loud, size: .large)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openSheet), for: .touchUpInside)
        return button
    }

    @objc
    private func titleEnabledDidChange(sender: Any) {
        guard let toggle = sender as? UISwitch else { return }
        configuration.titleEnabled = toggle.isOn
    }

    @objc
    private func sizePickerDidChange(sender: Any) {
        guard let segmented = sender as? UISegmentedControl else { return }
        configuration.size = Size(rawValue: segmented.selectedSegmentIndex) ?? .small
    }

    @objc
    private func presentationSizePickerDidChange(sender: Any) {
        guard let segmented = sender as? UISegmentedControl else { return }
        configuration.presentationStyle = AndesBottomSheetPresentationStyle(rawValue: segmented.selectedSegmentIndex) ?? .fixed
    }

    @objc
    private func openSheet() {
        let sheet = AndesBottomSheetViewController(rootViewController: BottomSheetExampleScrollableContentViewController(rowHeight: configuration.size.toConcreteSize()), presentationStyle: configuration.presentationStyle)
        sheet.titleBar.text = configuration.titleEnabled ? "This is a title" : nil
        sheet.titleBar.textAlignment = randomTextAlignment()
        present(sheet, animated: true)
    }

    private func randomTextAlignment() -> NSTextAlignment {
        switch Int.random(in: 0...2) {
        case 0:
            return .left
        case 1:
            return .right
        default:
            return .center
        }
    }
}
