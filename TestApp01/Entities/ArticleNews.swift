//
//  ArticleNews.swift
//  TestApp01
//
//  Created by user163112 on 12/24/19.
//  Copyright © 2019 admin. All rights reserved.
//

struct ArticleNews: Codable {
    var title: String
    var body: String
    var renderedBody: String
    var urlString: String
    var user: ArticleUser
    
    enum CodingKeys: String, CodingKey {
        case title
        case body
        case renderedBody = "rendered_body"
        case urlString = "url"
        case user
    }
}
