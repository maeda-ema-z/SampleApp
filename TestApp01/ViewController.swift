//
//  ViewController.swift
//  TestApp01
//
//  Created by admin on 12/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    fileprivate var articles: [Article] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArtcles()
        initTableView()
    }

    fileprivate func fetchArtcles() {
        // Do any additional setup after loading the view, typically from a nib.
        guard let url: URL = URL(string: "http://qiita.com/api/v2/items") else { return }
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            print("data: \(data)")
            print("response: \(response)")
            print("error: \(error)")
            do {
                guard let data = data else { return }
                guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any] else { return }
                print(jsonArray)
                print("count: \(jsonArray.count)")
                let articleJsonArray = jsonArray.flatMap { (json: Any) -> [String: Any]? in
                    return json as? [String: Any]
                }
                let articles = articleJsonArray.flatMap { (articleJson: [String: Any]) -> Article in
                    return Article(json: articleJson)
                }
            
                print("title: \(articleJsonArray[0]["title"])")
                print("hoge: \(articleJsonArray[0]["hoge"])")
                DispatchQueue.main.async() { () -> Void in
                    self.articles = articles
                }
            }
            catch {
                print(error)
            }
        })
        task.resume()
    }
    
    fileprivate func initTableView() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let article = articles[indexPath.row]
        //let title = article.title
        cell.bindData(article: article)
//        cell.bindData(text: "section: \(indexPath.section) index: \(indexPath.row)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section) index: \(indexPath.row)")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        return
    }
}
