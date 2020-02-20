//
//  LoginUseCase.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/20.
//  Copyright © 2020 admin. All rights reserved.
//

class LoginUseCase {
    // 本クラスはシングルトンで使用する
    static let shared = LoginUseCase()
    private init() {}

    func login(loginId: String, password: String) -> Bool {
        if loginId == "1234" && password == "0000" {
            return true
        } else {
            return false
        }
    }
}
