//
//  CompaniesController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class CompaniesController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    ///Set up initial UI layouts and attributes
    fileprivate func setup(){
        //View setup
        view.backgroundColor = .white
        
        //Nav set up
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddCompany(_:)))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "reset", style: .plain, target: self, action: #selector(handleAddCompany(_:)))
    }
    
    @objc func handleAddCompany(_ sender: Any){
        //TODO:- Add Company
    }
    
    @objc func handleResetCompany(_ sender: Any){
        //TODO:- Reset company
    }
}
