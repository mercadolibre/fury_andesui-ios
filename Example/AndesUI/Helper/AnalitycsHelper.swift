//
//  AnalitycsHelper.swift
//  AndesUI-demoapp
//
//  Created by Daniel Esteban Beltran Beltran on 12/02/21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import FirebaseAnalytics

class AnalyticsHelper {

    var screensAndTimers =  [String: Date]()
    var componentsDates = [String: [String: Date]]()
    var screensAndSeconds = [String: TimeInterval]()
    var componentsSeconds = [String: [String: TimeInterval]]()

    func startTimer(view: String, for component: String) {
        var screen = ""

        if view == "" {
            screen = AnalyticsEventScreenView
        } else {
            screen = view
        }

        screensAndTimers[screen] = Date()
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

            if currentComponentSeconds[screen] != nil {
                currentSeconds += currentComponentSeconds[screen]!
            }

            viewAndSeconds[screen] = currentSeconds
        }

        sendTrack(component: component, viewsAndSeconds: viewAndSeconds)
    }

    func sendTrack(component: String, viewsAndSeconds: [String: TimeInterval]) {
        print("\(component) -> \(viewsAndSeconds)")
//        print("nombre componente: \(component)")
//        Analytics.logEvent(component, parameters: viewsAndSeconds)
    }
}
