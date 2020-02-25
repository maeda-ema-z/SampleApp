//
//  DeviceUtil.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/25.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class DeviceUtil {
    // 本クラスはシングルトンで使用する
    static let shared = DeviceUtil()
    private init() {}

    func getDeviceIdentifier() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
