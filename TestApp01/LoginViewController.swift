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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        msgTextField.text = ""
        let ud = UserDefaults.standard
        if let loginId = ud.object(forKey: "loginId") as? String {
            loginIdTextField.text = loginId
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func LoginTouchDown(_ sender: Any) {
        let loginId = loginIdTextField.text
        let password = passwordTextField.text
        if loginId == "1234" && password == "0000" {
            let ud = UserDefaults.standard
            ud.set(loginId, forKey: "loginId")
            self.dismiss(animated: true, completion: nil)
        } else {
            msgTextField.text = "Please Input LoginID = 1234 , Password = 0000 !!"
        }
    }
}
