//
//  TagRouter.swift
//  AndesUI-demoapp
//
//  Created by Samuel Sainz on 5/29/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class TagsRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [TagViewController(), TagObjCViewController(), TagChoiceObjCViewController()])
        viewController.title = "AndesTag"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
