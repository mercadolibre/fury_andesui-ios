//
//  ProgressIndicatorRouter.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation
import UIKit

class ProgressIndicatorRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [ProgressIndicatorViewController(), ProgressIndicatorObjcViewController()])
        viewController.title = "AndesPogressindicator"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
