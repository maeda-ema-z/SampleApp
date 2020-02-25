//
//  LoginViewController.swift
//  TestApp01
//
//  Created by user163112 on 12/24/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
                self?.successAuth()
            },
            failure: { [weak self] (msg) in
                self?.failureAuth(message: msg)
            },
            retry: { [weak self] in
                self?.doRetry()
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
        let loginId = loginIdTextField.text
        let password = passwordTextField.text
        loginUseCase.login(loginId: loginId ?? "", password: password ?? "")
    }

    func successAuth() {
        let loginId = loginIdTextField.text
        let ud = UserDefaults.standard
        ud.set(loginId, forKey: "loginId")
        let naviC = self.presentingViewController as? UINavigationController
        let parentVC = naviC?.viewControllers.last as! ViewController
        parentVC.isLogin = true
        self.dismiss(animated: true, completion: nil)
    }

    func failureAuth(message: String) {
        //let aaa = UIDevice.current.identifierForVendor!.uuidString
        //msgTextField.text = aaa
        msgTextField.text = message
    }

    private func doRetry() -> Void {
        let dialog = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let attributedTitle = NSAttributedString(string: "通信エラー", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.red
        ])
        let attributedMessage = NSAttributedString(string: "ネット接続を確認してください", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray
        ])
        dialog.setValue(attributedTitle, forKey: "attributedTitle")
        dialog.setValue(attributedMessage, forKey: "attributedMessage")
        dialog.addAction(UIAlertAction(title: "再試行", style: .default, handler: {
            action in self.doLogin()}))
        dialog.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
}
