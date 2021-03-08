//
//  CardRouter.swift
//  AndesUI-demoapp
//
//  Created by Martin Victory on 14/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class CardRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [CardViewController(), CardObjCViewController()])
        viewController.title = "AndesCard"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
