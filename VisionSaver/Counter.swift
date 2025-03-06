//
//  Counter.swift
//  VisionSaver
//
//  Created by Vyacheslav on 02.03.2025.
//

import Foundation
import UserNotifications
import Combine

class Counter {
    var advanced: Advanced
    var cancellable: AnyCancellable?
    
    init(advanced: Advanced) {
        self.advanced = advanced
    }
    
    private var timer: Timer? = nil
    
    @Published public var currentCount: Int = 0
    
    private var notificationSent: Bool = false
    
    private var totalTime: Int = 0
    
    private var title: String = ""
    private var message: String = ""
    
    func startCount(seconds: Int, advanced: Advanced) {
        self.totalTime = seconds
        var count = seconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if count > 0 {
                self.notificationSent = false
                DispatchQueue.main.async {
                    count -= 1
                    print(count)
                    self.currentCount = count
                }
            } else {
                advanced.title = advanced.title
                
                if !self.notificationSent {
                    self.pushNotification(advanced: advanced)
                    self.notificationSent = true
                }
                
                self.timer?.invalidate()
                self.startCount(seconds: seconds, advanced: advanced)
            }
        }
    }
    
    func stopCounting() {
        timer?.invalidate()
    }
    
    func resumeCounting(advanced: Advanced) {
        var count = currentCount
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if count > 0 {
                DispatchQueue.main.async {
                    count -= 1
                    print(count)
                    self.currentCount = count
                }
            } else {
                if !self.notificationSent {
                    self.pushNotification(advanced: advanced)
                    self.notificationSent = true
                }
                
                self.timer?.invalidate()
                self.startCount(seconds: self.totalTime, advanced: advanced)
            }
        }
    }
    
    func pushNotification(advanced: Advanced) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Pushed notification")
                
                let content = UNMutableNotificationContent()
                content.title = advanced.title
                content.body = advanced.message
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
                let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error adding notification: \(error)")
                    }
                }
            } else {
                print("Error sending notification. Please check permissions.")
            }
        }
    }
    
    private func updateValues() {
        cancellable = advanced.$title.sink { newValue in
            self.title = newValue
        }
        
        cancellable = advanced.$message.sink { newValue in
            self.message = newValue
        }
    }
}
