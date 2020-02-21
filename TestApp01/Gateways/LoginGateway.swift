//
//  LoginGateway.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/21.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

class LoginGateway: HttpGateway<LoginResult> {
    func createLoginObservable(_ userId: String, _ password: String) -> Single<LoginResult> {
        let authParam = "deviceNo=2101&loginId=\(userId)&password=\(password)"
        return createHttpPostObservable(url: "http://10.241.64.107:8080/smhos/api/login", param: authParam) { data in
            do {
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode(LoginResult.self, from: data)
            } catch {
                print("decode error !!")
                return LoginResult(result: "ng")
            }
        }
    }
}
