//
//  LocalNotificationView.swift
//  ContinuedLearning
//
//  Created by Ricky Primayuda Putra on 09/12/24.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager: ObservableObject {
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification testing"
        content.subtitle = " This was soooo easyyy!"
        content.sound = .default
        content.badge = 1
        
        //time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        //calendar
//        var dateComponents = DateComponents()
//        dateComponents.hour = 8
//        dateComponents.minute = 0
//        dateComponents.weekday = 2
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        //location
        let coordinate = CLLocationCoordinate2D(
            latitude: 40.00,
            longitude: 50.00
        )
        
        let region = CLCircularRegion(
            center: coordinate,
            radius: 100,
            identifier: UUID().uuidString
        )
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
        
    }
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}

struct LocalNotificationView: View {
    
    @StateObject var nm = NotificationManager()
    
    var body: some View {
        VStack(spacing: 40) {
            Button {
                nm.requestAuthorization()
            } label: {
                Text("Request Permission")
            }
            Button {
                nm.scheduleNotification()
            } label: {
                Text("Schedule Notificaton ")
            }
            Button {
                nm.cancelNotification()
            } label: {
                Text("Cancel Notificaton ")
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

#Preview {
    LocalNotificationView()
}
