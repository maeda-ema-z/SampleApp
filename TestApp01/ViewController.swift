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

//    fileprivate let viewModel = ViewModel()
    private let articlePresenter = ArticlePresenter.shared
    private let articleModelHandler = ArticleModelHandler.shared
    private let articleNotificationTask = ArticleNotificationTask()

    var isLogin = false

//    fileprivate var articles: [Article] {
//        return viewModel.articles
//    }

    fileprivate var articleNewses: [ArticleNews] {
//        return viewModel.articleNewses
//        return viewModel.articleNewsVariable.value
        return articlePresenter.articleNewses
//        return articleModelHandler.articleNewsRelay.value
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
//        viewModel.fetchArticles()
//        articleModelHandler.fetchArticles()
        navigationLogin()
        initTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let presented = self.presentedViewController {
            print(presented)
            if type(of: presented) == LoginViewController.self {
                fetchAction()
                startNotification()
            }
        } else {
            print("none")
        }
    }

    private func fetchAction() {
        if isLogin {
//            viewModel.fetchArticles()
            articleModelHandler.fetchArticles()
        }
    }

    private func startNotification() {
        if isLogin {
            articleNotificationTask.startTImer()
        }
    }

    private func initViewModel() {
//        viewModel.reloadHandler = { [weak self] in
//            self?.tableView.reloadData()
//        }
//        viewModel.articleNewsVariable.asObservable()
//            .subscribe(onNext: { [weak self] articles in
//                self?.tableView?.reloadData()
//            })
//        .disposed(by: disposeBag)
//        articleModelHandler.articleNewsRelay
//            .observeOn(MainScheduler.instance)
//            .subscribe(
//            onNext: { [weak self] event in
////                self?.tableView?.reloadData()
//                self?.reloadData()
//            }
//        ).disposed(by: disposeBag)
        articlePresenter.initArticleViewModel() {
            self.tableView?.reloadData()
        }
    }

    fileprivate func initTableView() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func navigationLogin() {
        let loginSb: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let naviController = loginSb.instantiateViewController(withIdentifier: "loginSbId") as! LoginViewController
        naviController.modalPresentationStyle = .fullScreen
        self.present(naviController, animated: true, completion: nil)
//        self.present(naviController, animated: true, completion: {
//            print("aaaa")
//        })
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return articles.count
        return articleNewses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
//        let article = articles[indexPath.row]
//        cell.bindData(article: article)
        let articleNews = articleNewses[indexPath.row]
        cell.bindData(articleNews: articleNews)
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
//        vc.article = articles[indexPath.row]
        vc.articleNews = articleNewses[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
        let distanceToBottom = maximumOffset - currentOffsetY
        if distanceToBottom < 500 {
//            viewModel.fetchArticles()
//            articleModelHandler.fetchArticles()
            fetchAction()
        }
    }
}
