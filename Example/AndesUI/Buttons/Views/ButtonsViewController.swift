//
//  ButtonsViewController.swift
//  AndesUI_Example
//
//  Created by Santiago Lazzari on 19/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import UIKit

import AndesUI

class ButtonsViewController: UIViewController {

    @IBOutlet weak var andesButton: AndesButton!
    @IBOutlet weak var disabledAndesButton: AndesButton!

    @IBOutlet weak var largeLoudAndesButton: AndesButton!
    @IBOutlet weak var largeQuietAndesButton: AndesButton!
    @IBOutlet weak var largeTransparentAndesButton: AndesButton!
    @IBOutlet weak var largeLoudLeftImageAndesButton: AndesButton!
    @IBOutlet weak var largeLoudRightImageAndesButton: AndesButton!

    @IBOutlet weak var largeQuietLeftImageAndesButton: AndesButton!
    @IBOutlet weak var largeQuietRightImageAndesButton: AndesButton!

    @IBOutlet weak var largeTransparentLeftImageAndesButton: AndesButton!
    @IBOutlet weak var largeTransparentRightImageAndesButton: AndesButton!

    @IBOutlet weak var mediumLoudAndesButton: AndesButton!
    @IBOutlet weak var mediumQuietAndesButton: AndesButton!
    @IBOutlet weak var mediumTransparentAndesButton: AndesButton!

    @IBOutlet weak var smallLoudAndesButton: AndesButton!
    @IBOutlet weak var smallQuietAndesButton: AndesButton!
    @IBOutlet weak var smallTransparentAndesButton: AndesButton!

    @IBOutlet var largeWithSpinnerAndesButton: [AndesButton] = []
    @IBOutlet var mediumWithSpinnerAndesButton: [AndesButton] = []
    @IBOutlet var smallWithSpinnerAndesButton: [AndesButton] = []

    @IBOutlet weak var largeWithIconSpinner: AndesButton!
    @IBOutlet weak var switchStateLabel: UILabel!

    var rightBarButton: UIBarButtonItem!

    var spinnersState: SpinnerState = .disabled {
        didSet {
            self.changeSpinnerState(state: spinnersState)
        }
    }

    enum SpinnerState {
        case enabled
        case disabled

        mutating func changeSate() {
            let counterPart: SpinnerState = self == .enabled ? .disabled : .enabled
            self = counterPart
        }

        func getTransitionStateName() -> String {
            switch self {
            case .enabled:
                return "Enabled Spinner"
            case .disabled:
                return "Disabled Spinner"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        spinnersState = .enabled
    }

    @IBAction func ChangeSpinnerState(_ sender: Any) {
        spinnersState.changeSate()
    }

    func setupSizes() {
        // Large medium small
        largeWithIconSpinner.setLargeSizeWithIcon(AndesButtonIcon(icon: #imageLiteral(resourceName: "clip"), orientation: .left))
        largeLoudLeftImageAndesButton.setLargeSizeWithIcon(AndesButtonIcon(icon: #imageLiteral(resourceName: "clip"), orientation: .left))
        largeLoudRightImageAndesButton.setLargeSizeWithIcon(AndesButtonIcon(icon: #imageLiteral(resourceName: "clip"), orientation: .right))

        largeQuietLeftImageAndesButton.setLargeSizeWithIcon(AndesButtonIcon(icon: #imageLiteral(resourceName: "clip"), orientation: .left))
        largeQuietRightImageAndesButton.setLargeSizeWithIcon(AndesButtonIcon(icon: #imageLiteral(resourceName: "clip"), orientation: .right))

        largeTransparentLeftImageAndesButton.setLargeSizeWithIcon(AndesButtonIcon(icon: #imageLiteral(resourceName: "clip"), orientation: .left))
        largeTransparentRightImageAndesButton.setLargeSizeWithIcon(AndesButtonIcon(icon: #imageLiteral(resourceName: "clip"), orientation: .right))

    }

    func setTexts() {
        navigationItem.title = "Buttons"
    }

    func setupUI() {
        disabledAndesButton.isEnabled = false
        setTexts()
        setupSizes()
    }

    func changeSpinnerState(state: SpinnerState) {

        switchStateLabel.text = state.getTransitionStateName()

        switch state {
        case .enabled:
            self.startSpinners()
        case .disabled:
            self.stopSpinners()
        }
    }

    func startSpinners() {

        largeWithIconSpinner.startSpinner()

        largeWithSpinnerAndesButton.forEach {
            $0.startSpinner()
        }

        mediumWithSpinnerAndesButton.forEach {
            $0.startSpinner()
        }

        smallWithSpinnerAndesButton.forEach {
            $0.startSpinner()
        }
    }

    func stopSpinners() {

        largeWithIconSpinner.stopSpinner()

        largeWithSpinnerAndesButton.forEach {
            $0.stopSpinner()
        }

        mediumWithSpinnerAndesButton.forEach {
            $0.stopSpinner()
        }

        smallWithSpinnerAndesButton.forEach {
            $0.stopSpinner()
        }
    }
}
