//
//  MessagesRouter.swift
//  AndesUI_Example
//
//  Created by Nicolas Rostan Talasimov on 1/16/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class MessagesRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [MessageViewController(), MessageObjCViewController()])
        viewController.title = "AndesMessage"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
