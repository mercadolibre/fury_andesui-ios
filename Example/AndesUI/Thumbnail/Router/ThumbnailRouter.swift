//
//  ThumbnailRouter.swift
//  AndesUI-demoapp
//
//  Created by Alejo Echeguia on 01/07/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation

class ThumbnailRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [ThumbnailViewController(), ThumbnailObjCViewController()])
        viewController.title = "AndesThumbnail"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
