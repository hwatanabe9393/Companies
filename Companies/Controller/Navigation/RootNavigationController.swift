//
//  RootNavigationController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class RootNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    ///Set up initial UI layouts and attributes
    fileprivate func setup(){
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .red
        navigationBar.tintColor = .white
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}

extension UINavigationController{
    override open var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
