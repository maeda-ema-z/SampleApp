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

class ArticleModelHandler {
    static let shared: ArticleModelHandler = ArticleModelHandler()
    private init() {}

    private var myPageNo: Int = 1
    private var loadStatus: String = "initial"

    private let disposeBag = DisposeBag()

    var articleNewses: [ArticleNews] = []

    let articleNewsRelay = PublishRelay<Bool>()
//    var articleNewsRelay = BehaviorRelay<[ArticleNews]>(value:[])

    enum MyError: Error {
        case unknown
    }

    func fetchArticles() {
        guard loadStatus != "fetching" && loadStatus != "full" else { return }
        loadStatus = "fetching"
        createFetchObservable(page: myPageNo).subscribe(
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

    func createFetchObservable(page: Int) -> Single<[ArticleNews]> {
        return Single<[ArticleNews]>.create( subscribe : { (observer) -> Disposable in
            if let url: URL = URL(string: "http://qiita.com/api/v2/items?page=\(page)&per_page=20") {
                let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
                    do {
                        if let data = data {
                            let jsonDecoder = JSONDecoder()
                            let articleNewses = try jsonDecoder.decode([ArticleNews].self, from: data)
                            observer(.success(articleNewses))
                        } else {
                            observer(.error(error ?? MyError.unknown))
                        }
                    }
                    catch {
                        print(error)
                    }
                })
                task.resume()
            } else {
                observer(.error(MyError.unknown))
            }
            return Disposables.create()
        })
    }
}
