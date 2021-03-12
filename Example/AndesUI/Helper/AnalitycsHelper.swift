//
//  AnalitycsHelper.swift
//  AndesUI-demoapp
//
//  Created by Daniel Esteban Beltran Beltran on 12/02/21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import FirebaseAnalytics

enum TimerAction {
    case start
    case pause
    case stop
}

enum ScreenTypeEvent: String {
    case dynamicScreen = "dynamic"
    case staticScreem = "static"
}

class AnalyticsHelper {

    private var screensAndTimers =  [String: Date]()
    private var componentsDates = [String: [String: Date]]()
    private var screensAndSeconds = [String: TimeInterval]()
    private var componentsSeconds = [String: [String: TimeInterval]]()

    private var viewAndPath: [String: String] = [
        "TooltipObjcViewController": "",
        "TooltipViewController": "'\'dynamic",
        "AndesBadgeExtensionTabBarController": "'\'dynamic",
        "CoachmarkViewController": "'\'dynamic",
        "CoachmarkObjCViewController": "'\'static",
        "BottomSheetSwiftExampleViewController": "'\'static",
        "ButtonsViewController": "'\'static",
        "MessageViewController": "'\'dynamic",
        "MessageObjCViewController": "'\'static",
        "TextFieldViewController": "'\'dynamic",
        "TextAreaViewController": "'\'dynamic",
        "TextFieldObjCViewController": "'\'static",
        "TextFieldsCodeViewController": "'\'dynamic",
        "TextFieldsCodeObjCViewController": "'\'dynamic",
        "AndesRadioButtonViewController": "''\'radiobutton\'dynamic",
        "RadioButtonObjCViewController": "''\'radiobutton'\'static",
        "BadgeViewController": "'\'static",
        "BadgeObjCViewController": "'\'dynamic",
        "AndesCheckboxInitViewController": "'\'dynamic",
        "CheckboxObjCViewController": "'\'static",
        "AndesCheckboxViewController": "'\'static",
        "TagViewController": "'\'dynamic",
        "TagObjCViewController": "'\'static",
        "TagChoiceObjCViewController": "'\'static",
        "SnackbarViewController": "'\'dynamic",
        "SnackbarObjCViewController": "'\'static",
        "CardViewController": "'\'dynamic",
        "CardObjCViewController": "'\'static",
        "DatePickerViewController": "'\'dynamic",
        "ThumbnailViewController": "'\'static",
        "ThumbnailObjCViewController": "'\'static",
        "ListViewController": "'\'dynamic",
        "ListObjcViewController": "'\'static",
        "DropdownViewController": "\'dynamic",
        "DropDownObjcViewController": "\'dynamic",
        "BadgeViewController": "\'dynamic",
        "BadgeObjCViewController": "'\'static"
    ]

    func startTimer(view: String?, for component: String) {
        screensAndTimers[view ?? AnalyticsEventScreenView] = Date()
        componentsDates[component] = screensAndTimers
    }

    func pauseTimer(view: String, and component: String) {
        guard let finalDate = componentsDates[component]?[view] else { return }

        let currentSeconds = Date().timeIntervalSince(finalDate)
        if screensAndSeconds[view] != nil {
            screensAndSeconds[view]! += currentSeconds
        } else {
            screensAndSeconds[view] = currentSeconds
        }

        componentsSeconds[component] = screensAndSeconds
    }

    func stopTimer(component: String) {
        guard let currentComponentSeconds = componentsSeconds[component],
              let currentComponentDates = componentsDates[component]
              else { return }
        var viewAndSeconds = [String: TimeInterval]()

        for screenDates in currentComponentDates {
            let screen = screenDates.key
            let date = screenDates.value
            var currentSeconds = Date().timeIntervalSince(date)

            if let currentScreen = currentComponentSeconds[screen] {
                currentSeconds += currentScreen
            }

            viewAndSeconds[screen] = currentSeconds
        }

        sendTrack(component: component, viewsAndSeconds: viewAndSeconds)
    }

    func sendTrack(component: String, viewsAndSeconds: [String: TimeInterval]) {
        Analytics.logEvent(component, parameters: viewsAndSeconds)
    }

    func createPathWith(_ component: String, view: String, variation: String? = nil) {

        guard let path = viewAndPath[view] else {return}

        sendNewTrack(component: component, path: path)
    }

    func sendNewTrack(component: String, path: String) {
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters: [AnalyticsParameterScreenName: path,
                                        AnalyticsParameterScreenClass: component])
    }
}
