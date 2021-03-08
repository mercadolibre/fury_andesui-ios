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

class AnalyticsHelper {

    private var screensAndTimers =  [String: Date]()
    private var componentsDates = [String: [String: Date]]()
    private var screensAndSeconds = [String: TimeInterval]()
    private var componentsSeconds = [String: [String: TimeInterval]]()

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
}
