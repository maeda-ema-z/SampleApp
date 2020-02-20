//
//  ArticleNotificationManager.swift
//  TestApp01
//
//  Created by user163112 on 12/27/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import UserNotifications

class ArticleNotificationPresenter: NSObject, UNUserNotificationCenterDelegate {
    static let shared = ArticleNotificationPresenter()

    private override init() {
        super.init()
        regist()
    }

    func regist() {

        if #available(iOS 10.0, *) {

            print("regist UNUserNotificationCenter")
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {(granted, error) in
                let ud = UserDefaults.standard
                if error != nil {
                    print("Error !!")
                    return
                }
                if granted {
                    print("OK !!")
                    center.delegate = self
                    ud.set(true, forKey: "isNotification")
                } else {
                    print("NG !!")
                    ud.set(false, forKey: "isNotification")
                }
            })

        } else {

            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresent")
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive")
        completionHandler()
    }

    func add() {
        let content = UNMutableNotificationContent()
        content.title = "New Article."
        content.subtitle = "This is Test !!"
        content.body = "------------( Body )-------------"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(1), repeats: false)

        let request = UNNotificationRequest(identifier: "REQUEST", content: content, trigger: trigger)

        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
}
