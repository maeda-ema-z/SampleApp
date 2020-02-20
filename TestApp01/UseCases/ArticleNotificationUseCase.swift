//
//  ArticleNotificationUseCase.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/20.
//  Copyright © 2020 admin. All rights reserved.
//

class ArticleNotificationUseCase {
    // 本クラスはシングルトンで使用する
    static let shared = ArticleNotificationUseCase()
    private init() {}

    private let articleNotificationPresenter = ArticleNotificationPresenter.shared

    func sendNotification() -> Void {
        articleNotificationPresenter.addNotification()
    }
}
