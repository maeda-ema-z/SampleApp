//
//  LoginResult.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/21.
//  Copyright © 2020 admin. All rights reserved.
//

struct LoginResult: Codable {
    var result: String
    enum CodingKeys: String, CodingKey {
        case result
    }
}
