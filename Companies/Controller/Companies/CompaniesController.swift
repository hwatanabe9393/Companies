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
    let companies = [
        Company(name: "Google", founded: Date()),
        Company(name: "FaceBook", founded: Date()),
        Company(name: "Amazon", founded: Date())
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    ///Set up initialize UI layouts and attributes
    fileprivate func setup(){
        //TableView
        tableView.register(CompanyCell.self, forCellReuseIdentifier: companyCellId)
        tableView.backgroundColor = .darkBlue
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .white
        
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .lightBlue
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: companyCellId, for: indexPath) as! CompanyCell
        cell.textLabel?.text = companies[indexPath.row].name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.backgroundColor = .tealColor
        return cell
    }
}
