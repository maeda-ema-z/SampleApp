//
//  ArticleNewsGateway.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/20.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift
import RxCocoa

class ArticleNewsGateway {
    static let shared: ArticleNewsGateway = ArticleNewsGateway()
    private init() {}

    enum MyError: Error {
        case unknown
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
