//
//  CompaniesController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class CompaniesController: UITableViewController {
    let companyCellId = "companyCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CompanyCell.self, forCellReuseIdentifier: companyCellId)
        
        setup()
    }
    
    ///Set up initial UI layouts and attributes
    fileprivate func setup(){
        //TableView
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
        tableView.tableFooterView = UIView()
        
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
    
    //MARK:- TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: companyCellId, for: indexPath) as! CompanyCell
        cell.backgroundColor = .yellow
        return cell
    }
}
