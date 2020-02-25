//
//  LoginUseCase.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/20.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift
import RxCocoa

class LoginUseCase {
    // 本クラスはシングルトンで使用する
    static let shared = LoginUseCase()
    private init() {}

    private let loginGateway = LoginGateway()
    private let disposeBag = DisposeBag()
    let loginRelay = PublishRelay<Bool>()

    private var loginResult: LoginResult? = nil

    func login(loginId: String, password: String) {
        loginGateway.createLoginObservable(loginId, password).subscribe(
            onSuccess: { [weak self] result in
                self?.loginResult = result
                self?.loginRelay.accept(true)
            },
            onError: { [weak self] error in
                self?.loginResult = LoginResult(result: "ng")
                self?.loginRelay.accept(false)
            }
        ).disposed(by: disposeBag)
    }

    func isSuccess() -> Bool {
        if let loginResult = loginResult {
            if loginResult.result == "ok" {
                return true
            }
        }
        return false
    }
}
