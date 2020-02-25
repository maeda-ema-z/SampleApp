//
//  CommonViewController.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/25.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CommonViewController: UIViewController {

    func showSendErrorRetryDialog(retry: @escaping () -> Void) {
        showRetryDialog(title: "通信エラー", message: "ネット接続を確認してください") {
            retry()
        }
    }

    private func showRetryDialog(title: String, message: String, retry: @escaping () -> Void) -> Void {
        let dialog = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let attributedTitle = NSAttributedString(string: title, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.red
        ])
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.darkGray
        ])
        dialog.setValue(attributedTitle, forKey: "attributedTitle")
        dialog.setValue(attributedMessage, forKey: "attributedMessage")
        dialog.addAction(UIAlertAction(title: "再試行", style: .default, handler: {
            action in retry()}))
        dialog.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
}
