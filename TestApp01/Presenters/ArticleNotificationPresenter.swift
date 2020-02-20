//
//  ArticleNotificationManager.swift
//  TestApp01
//
//  Created by user163112 on 12/27/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UserNotifications

class ArticleNotificationPresenter {
    // 本クラスはシングルトンで使用する
    static let shared = ArticleNotificationPresenter()
    private init() {}

    // 通知センターPresenterのインスタンスを生成するために宣言する
    private let notificationCenterPresenter = NotificationCenterPresenter.shared

    func addNotification() {
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
