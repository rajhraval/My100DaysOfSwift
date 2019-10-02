//
//  ViewController.swift
//  Project21
//
//  Created by RAJ RAVAL on 01/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
        
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in
            if granted {
                print("Yay")
            } else {
                print("D'oh")
            }
        }
    }
    
    @objc func scheduleLocal() {
        registerCategories()
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Late Wake Up Call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.second = 86400
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let dayTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        let dayRequest = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: dayTrigger)
        
        center.add(request)
        center.add(dayRequest)
        
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell Me More", options: .foreground)
        let remind = UNNotificationAction(identifier: "remind", title: "Remind me after 24 hours", options: .foreground)
        
        let category = UNNotificationCategory(identifier: "alarm", actions: [show, remind], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let customData = userInfo["customData"] as? String {
            print("Custom data recieved \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                // Swiped to Unlock
                print("Default Identifier")
            case "show":
                print("Show more information")
                showAlert(title: "Custom Identifier", message: "You perform a notification action")
            case "remind":
                scheduleLocal()
            default:
                break
            }
        }
        completionHandler()
    }

    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
}

