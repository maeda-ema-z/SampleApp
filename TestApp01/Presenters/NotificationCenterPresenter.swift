//
//  NotificationCenterPresenter.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationCenterPresenter: NSObject, UNUserNotificationCenterDelegate {
    // 本クラスはシングルトンで使用する
    static let shared = NotificationCenterPresenter()

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
}
