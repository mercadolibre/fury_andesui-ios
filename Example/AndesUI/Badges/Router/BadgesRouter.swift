//
//  BadgesRouter.swift
//  AndesUI-demoapp
//

import Foundation

class BadgesRouter: HomeRouterProtocol {
    func route(from: UIViewController) {
        let viewController = AndesShowcasePageViewController(controllers: [BadgeViewController(), BadgeObjCViewController()])
        viewController.title = "AndesBadge"
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
