//
//  LoginViewController.swift
//  TestApp01
//
//  Created by user163112 on 12/24/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {

    @IBOutlet weak var loginIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var msgTextField: UILabel!

    private let loginPresenter = LoginPresenter.shared
    private let loginUseCase = LoginUseCase.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initPresenter()
        initInputField()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func initPresenter() {
        loginPresenter.initLoginViewModel(
            success: { [weak self] in
                self?.stopWaitIndicator()
                self?.successAuth()
            },
            failure: { [weak self] (msg) in
                self?.stopWaitIndicator()
                self?.failureAuth(message: msg)
            },
            retry: { [weak self] in
                self?.stopWaitIndicator()
                self?.showSendErrorRetryDialog() {
                    self?.doLogin()
                }
            }
        )
    }

    private func initInputField() {
        msgTextField.text = ""
        let ud = UserDefaults.standard
        if let loginId = ud.object(forKey: "loginId") as? String {
            loginIdTextField.text = loginId
        }
    }

    @IBAction func LoginTouchDown(_ sender: Any) {
        doLogin()
    }

    func doLogin() {
        self.startWaitIndicator()
        let loginId = loginIdTextField.text
        let password = passwordTextField.text
        loginUseCase.login(loginId: loginId ?? "", password: password ?? "")
    }

    func successAuth() {
        let loginId = loginIdTextField.text
        let ud = UserDefaults.standard
        ud.set(loginId, forKey: "loginId")
        let naviC = self.presentingViewController as? UINavigationController
        let parentVC = naviC?.viewControllers.last as! ArticleViewController
        parentVC.isLogin = true
        self.dismiss(animated: true, completion: nil)
    }

    func failureAuth(message: String) {
        //let aaa = UIDevice.current.identifierForVendor!.uuidString
        //msgTextField.text = aaa
        msgTextField.text = message
    }
}
