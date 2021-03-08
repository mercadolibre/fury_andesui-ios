//
//  UITabBarItemAndesBadgeViewController.swift
//  AndesUI-demoapp
//
//  Created by Julián Lima on 04/02/2021.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

final class AndesBadgeExtensionTabBarController: UITabBarController {
    init() {
        super.init(nibName: "AndesBadgeExtensionTabBarController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AndesStyleSheetManager.styleSheet.bgColorWhite
        viewControllers = [AndesBadgeExtensionViewControllerMock(title: "Home", badgeCount: -1)]
    }
}
