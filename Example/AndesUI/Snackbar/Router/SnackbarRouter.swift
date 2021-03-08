//
//  SnackbarRouter.swift
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 6/16/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class SnackbarRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [SnackbarViewController(), SnackbarObjCViewController()])
        viewController.title = "AndesSnackbar"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
