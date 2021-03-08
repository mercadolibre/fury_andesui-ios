//
//  ProgressIndicatorViewController.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class ProgressIndicatorViewController: UIViewController {

    @IBOutlet weak var progressIndicatorLargeWithText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorSmallWithText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorMediumWithText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorXSmallWithText: AndesProgressIndicatorIndeterminate!

    @IBOutlet weak var progressIndicatorLargeWithoutText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorSmallWithoutText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorMediumWithoutText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorXSmallWithoutText: AndesProgressIndicatorIndeterminate!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }

    private func startAnimation() {
        progressIndicatorLargeWithText.startAnimation()
        progressIndicatorSmallWithText.startAnimation()
        progressIndicatorMediumWithText.startAnimation()
        progressIndicatorXSmallWithText.startAnimation()

        progressIndicatorLargeWithoutText.startAnimation()
        progressIndicatorSmallWithoutText.startAnimation()
        progressIndicatorMediumWithoutText.startAnimation()
        progressIndicatorXSmallWithoutText.startAnimation()
    }

    private func stopAnimation() {
        progressIndicatorLargeWithText.stopAnimation()
        progressIndicatorSmallWithText.stopAnimation()
        progressIndicatorMediumWithText.stopAnimation()
        progressIndicatorXSmallWithText.stopAnimation()

        progressIndicatorLargeWithoutText.stopAnimation()
        progressIndicatorSmallWithoutText.stopAnimation()
        progressIndicatorMediumWithoutText.stopAnimation()
        progressIndicatorXSmallWithoutText.stopAnimation()
    }
}
