//
//  ViewModel.swift
//  TestApp01
//
//  Created by user163112 on 12/23/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ViewModel {

    private var page: Int = 1
    private var loadStatus: String = "initial"

    var articles: [Article] = [] {
        didSet {
            reloadHandler() //追加
        }
    }

    var reloadHandler: () -> Void = { } //追加

    func fetchArticles() {
        guard loadStatus != "fetching" && loadStatus != "full" else { return }
        loadStatus = "fetching"
        guard let url: URL = URL(string: "http://qiita.com/api/v2/items?page=\(page)&per_page=20") else { return }
        let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            do {
                guard let data = data else { return }
                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any] else { return }
                let articlesJson = jsonArray.flatMap { (json: Any) -> [String: Any]? in
                    return json as? [String: Any]
                }
                let articles = articlesJson.map { (articleJson: [String: Any]) -> Article in
                    return Article(json: articleJson)
                }
                if articles.count == 0 {
                    self.loadStatus = "full"
                    return
                }
                DispatchQueue.main.async() { () -> Void in
                    self.articles = self.articles + articles
                    self.loadStatus = "loadmore"
                }
                if self.page == 100 {
                    self.loadStatus = "full"
                    return
                }
                self.page += 1
            }
            catch {
                print(error)
                self.loadStatus = "error"
            }
        })
        task.resume()
    }
}
