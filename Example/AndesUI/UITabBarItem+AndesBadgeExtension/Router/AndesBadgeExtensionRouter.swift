//
//  AndesBadgeExtensionRoutern.swift
//  AndesUI-demoapp
//
//  Created by Julián Lima on 03/02/2021.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

class AndesBadgeExtensionRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [AndesBadgeExtensionTabBarController()])
        viewController.title = "AndesBadgeInTabBar"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
