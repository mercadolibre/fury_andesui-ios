//
//  BottomSheetRouter.swift
//  AndesUI-demoapp
//
//  Created by Tomi De Lucca on 29/10/2020.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit

class BottomSheetRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [BottomSheetSwiftExampleViewController(), BottomSheetObjectiveCExampleViewController()])
        viewController.title = "AndesBottomSheet"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
