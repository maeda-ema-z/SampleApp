//
//  ArticleUser.swift
//  TestApp01
//
//  Created by user163112 on 12/24/19.
//  Copyright © 2019 admin. All rights reserved.
//

struct ArticleUser: Codable {
    var id: String
    var profileImageUrlString: String

    enum CodingKeys: String, CodingKey {
        case id
        case profileImageUrlString = "profile_image_url"
    }
}
