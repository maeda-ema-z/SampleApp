//
//  ArticleDetailViewController.swift
//  TestApp01
//
//  Created by user163112 on 12/24/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var bodyLabel: UILabel!

//    var article: Article?
    var articleNews: ArticleNews?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        bodyLabel.text = article?.body
        bodyLabel.text = articleNews?.body
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
