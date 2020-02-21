//
//  ArticleModelHandler.swift
//  TestApp01
//
//  Created by user163112 on 12/25/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ArticleNewsUseCase {
    // 本クラスはシングルトンで使用する
    static let shared = ArticleNewsUseCase()
    private init() {}

    private let articleNewsGateway = ArticleNewsGateway()

    private var myPageNo: Int = 1
    private var loadStatus: String = "initial"

    private let disposeBag = DisposeBag()

    var articleNewses: [ArticleNews] = []

    let articleNewsRelay = PublishRelay<Bool>()
//    var articleNewsRelay = BehaviorRelay<[ArticleNews]>(value:[])

    func fetchArticles() {
        guard loadStatus != "fetching" && loadStatus != "full" else { return }
        loadStatus = "fetching"
        articleNewsGateway.createFetchObservable(page: myPageNo).subscribe(
            onSuccess: { [weak self] articleNewses in
                if articleNewses.count == 0 {
                    self?.loadStatus = "full"
                } else {
//                    DispatchQueue.main.async() { () -> Void in
                        self?.articleNewses.append(contentsOf: articleNewses)
                        self?.articleNewsRelay.accept(true)
//                        self?.articleNewsRelay.accept(self?.articleNewses ?? [])
//                    }
                    self?.loadStatus = "loadmore"
                    self?.myPageNo += 1
                }
            },
            onError: { [weak self] error in
                self?.loadStatus = "error"
            }
        ).disposed(by: disposeBag)
    }
}
