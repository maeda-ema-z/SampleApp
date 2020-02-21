//
//  ArticleNewsGateway.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/20.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift

class ArticleNewsGateway: HttpGateway<[ArticleNews]> {

    func createFetchObservable(page: Int) -> Single<[ArticleNews]> {
        return createHttpObservable(url: "http://qiita.com/api/v2/items?page=\(page)&per_page=20") { data in
            do {
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode([ArticleNews].self, from: data)
            } catch {
                print("decode error !!")
                return []
            }
        }
    }
}
