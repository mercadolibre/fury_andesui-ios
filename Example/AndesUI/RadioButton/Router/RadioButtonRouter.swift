//
//  RadioButtonRouter.swift
//  AndesUI-demoapp
//
//  Created by Rodrigo Pintos Costa on 6/30/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class RadioButtonRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [AndesRadioButtonViewController(), RadioButtonObjCViewController()])
        viewController.title = "AndesRadioButton"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
