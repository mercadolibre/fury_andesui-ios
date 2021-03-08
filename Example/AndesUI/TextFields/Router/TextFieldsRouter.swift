//
//  TextFieldsRouter.swift
//  AndesUI-demoapp
//
//  Created by Martin Damico on 13/03/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class TextFieldsRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [TextFieldViewController(), TextAreaViewController(), TextFieldObjCViewController()])
        viewController.title = "AndesTextField"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
