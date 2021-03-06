//
//  LoginPresenter.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/21.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

class LoginPresenter {
    // 本クラスはシングルトンで使用する
    static let shared = LoginPresenter()
    private init() {}

    private let loginUseCase = LoginUseCase.shared
    private let disposeBag = DisposeBag()

    func initLoginViewModel(
        success: @escaping () -> Void,
        failure: @escaping (String) -> Void,
        retry: @escaping () -> Void) {

        loginUseCase.loginRelay
            .observeOn(MainScheduler.instance)
            .subscribe(
            onNext: { [weak self] event in
                print("event=\(event)")
                if event {
                    if self?.loginUseCase.isSuccess() ?? false {
                        success()
                    } else {
                        failure("Please Input LoginID = 1234 , Password = 0000 !!")
                    }
                } else {
                    retry()
                }
            }
        ).disposed(by: disposeBag)
    }
}
