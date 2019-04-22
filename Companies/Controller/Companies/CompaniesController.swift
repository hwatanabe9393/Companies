//
//  CompaniesController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    ///Set up initial UI layouts and attributes
    fileprivate func setup(){
        //TableView
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
        tableView.separatorStyle = .none
        
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
