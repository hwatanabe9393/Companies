//
//  UIAlertController + ErrorMessage.swift
//  Companies
//
//  Created by Hikaru Watanabe on 5/16/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit
extension UIAlertController{
    static func errorMessage(header: String, message: String)->UIAlertController{
        let failedAlertController = UIAlertController(title: header, message: message, preferredStyle: .alert)
        failedAlertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return failedAlertController
    }
}
