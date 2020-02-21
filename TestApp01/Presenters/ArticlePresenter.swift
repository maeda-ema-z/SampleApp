//
//  ArticlePresenter.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/20.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

class ArticlePresenter {
    // 本クラスはシングルトンで使用する
    static let shared = ArticlePresenter()
    private init() {}

    private let articleNewsUseCase = ArticleNewsUseCase.shared
    private let disposeBag = DisposeBag()

//    var reloadFunc: () -> Void = {}

    var articleNewses: [ArticleNews] {
        return articleNewsUseCase.articleNewses
    }

    func initArticleViewModel(reload: @escaping () -> Void) {
//        reloadFunc = reload
        articleNewsUseCase.articleNewsRelay
            .observeOn(MainScheduler.instance)
            .subscribe(
            onNext: { event in
//                reloadFunc()
                reload()
            }
        ).disposed(by: disposeBag)
    }
}
