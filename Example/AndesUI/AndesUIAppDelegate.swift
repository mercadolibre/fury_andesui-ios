//
//  AndesUIAppDelegate.swift
//  AndesUI
//
//  Created by LFuryk on 11/26/2019.
//  Copyright (c) 2019 Mercado Libre. All rights reserved
//

import UIKit
import AndesUI
import IQKeyboardManagerSwift
import Firebase

@UIApplicationMain
class AndesUIAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let homeRouter = HomeAppRouter()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupIQKeyboardManager()
        UINavigationBar.appearance().barTintColor = AndesStyleSheetManager.styleSheet.accentColor
        UINavigationBar.appearance().tintColor = AndesStyleSheetManager.styleSheet.bgColorWhite
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: AndesStyleSheetManager.styleSheet.bgColorWhite]

        self.window = UIWindow(frame: UIScreen.main.bounds)
        homeRouter.start(in: window!)

        // Disable dark mode.
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }

        FirebaseApp.configure()

        return true
    }

    fileprivate func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 30
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
