//
//  ArticleNotificationTask.swift
//  TestApp01
//
//  Created by user163112 on 12/27/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import UserNotifications

class ArticleNotificationResident {
    // 本クラスはシングルトンで使用する
    static let shared = ArticleNotificationResident()
    private init() {}

    private let articleNotificationPresenter = ArticleNotificationPresenter.shared

    func startTImer() -> Void {
        Timer.scheduledTimer(
            timeInterval: 15,
            target: self,
            selector: #selector(ArticleNotificationResident.timerExecute),
            userInfo: nil,
            repeats: true)
    }

    @objc func timerExecute() {
        print("timerExecute !!")
        articleNotificationPresenter.addNotification()
    }
}
