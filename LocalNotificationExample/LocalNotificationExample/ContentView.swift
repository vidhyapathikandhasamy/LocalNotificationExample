//
//  ContentView.swift
//  LocalNotificationExample
//
//  Created by Vidhyapathi on 29/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Local Notification")
                .font(.largeTitle)
                .padding()
            HStack(spacing: 20) {
                Button("Schedule Notification") {
                    scheduleNotification(title: "Hello", body: "This is a local notification", timeInterval: 5.0)
                }
                .frame(width: 100, height: 100)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(5.0)
                
                Button("Delete Notification") {
                    removeDeliveredNotification(identifier: loadIdentifier() ?? "")
                }
                .frame(width: 100, height: 100)
                .background(Color.red)
                .foregroundColor(Color.white)
                .cornerRadius(5.0)
            }
            
            .padding()
            
        }
        
    }
    
    func removeDeliveredNotification(identifier: String) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
    }
    
    func scheduleNotification(title: String, body: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        // Create a trigger to fire the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        // Create a request
        let getIdentifier = UUID().uuidString
        self.saveIdentifier(getIdentifier)
        let request = UNNotificationRequest(identifier: getIdentifier, content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }
    
    func saveIdentifier(_ identifier: String) {
        UserDefaults.standard.set(identifier, forKey: "identifier")
    }
    
    func loadIdentifier() -> String? {
        return UserDefaults.standard.string(forKey: "identifier")
    }
}

#Preview {
    ContentView()
}
