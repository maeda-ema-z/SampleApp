//
//  Article.swift
//  TestApp01
//
//  Created by user163112 on 12/23/19.
//  Copyright © 2019 admin. All rights reserved.
//

// import Foundation

struct Article {
    let title: String
    let body: String
    let renderedBody: String
    let urlString: String
    let userId: String
    let profileImageUrlString: String

    init(json: [String: Any]) {
        title = json["title"] as? String ?? ""
        body = json["body"] as? String ?? ""
        renderedBody = json["rendered_body"] as? String ?? ""
        urlString = json["url"] as? String ?? ""
        if let user = json["user"] as? [String: Any] {
            userId = user["id"] as? String ?? ""
            profileImageUrlString = user["profile_image_url"] as? String ?? ""
        } else {
            userId = ""
            profileImageUrlString = ""
        }
    }

    init() {
        title = ""
        body = ""
        renderedBody = ""
        urlString = ""
        userId = ""
        profileImageUrlString = ""
    }
}
