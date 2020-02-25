//
//  ViewController.swift
//  TestApp01
//
//  Created by admin on 12/10/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let articlePresenter = ArticlePresenter.shared
    private let articleNewsUseCase = ArticleNewsUseCase.shared
    private let articleNotificationResident = ArticleNotificationResident.shared

    var isLogin = false

    fileprivate var articleNewses: [ArticleNews] {
        return articlePresenter.articleNewses
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initPresenter()
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
            articleNewsUseCase.fetchArticles()
        }
    }

    private func startNotification() {
        if isLogin {
            articleNotificationResident.startTImer()
        }
    }

    private func initPresenter() {
        articlePresenter.initArticleViewModel() { [weak self] in
            self?.tableView?.reloadData()
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

extension ArticleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleNewses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let articleNews = articleNewses[indexPath.row]
        cell.bindData(articleNews: articleNews)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section) index: \(indexPath.row)")
        let vc = UIStoryboard(name: "ArticleDetail", bundle: nil).instantiateInitialViewController()! as! ArticleDetailViewController
        vc.articleNews = articleNewses[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
        let distanceToBottom = maximumOffset - currentOffsetY
        if distanceToBottom < 500 {
            fetchAction()
        }
    }
}
