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

    fileprivate let viewModel = ViewModel()

    fileprivate var articles: [Article] {
        return viewModel.articles
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        viewModel.fetchArticles()
        initTableView()
    }

    private func initViewModel() {
        viewModel.reloadHandler = { [weak self] in
            self?.tableView.reloadData()
        }
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
        let vc = UIStoryboard(name: "ArticleDetail", bundle: nil).instantiateInitialViewController()! as! ArticleDetailViewController
        vc.article = articles[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
        let distanceToBottom = maximumOffset - currentOffsetY
        if distanceToBottom < 500 {
            viewModel.fetchArticles()
        }
    }
}
