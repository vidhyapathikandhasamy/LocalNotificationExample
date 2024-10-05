//
//  LocalNotificationExampleApp.swift
//  LocalNotificationExample
//
//  Created by Vidhyapathi on 29/09/24.
//

import SwiftUI
import UserNotifications

@main
struct LocalNotificationExampleApp: App {
    
    init() {
        requestNotificationPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
            }
        }
    }
    
}
