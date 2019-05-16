//
//  CompaniesController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController  {
    let companyCellId = "companyCellId"
    var companies = [Company]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchCompanies()
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "reset", style: .plain, target: self, action: #selector(handleResetCompany(_:)))
    }
    
    fileprivate func fetchCompanies(){
        CoreDataManager.shared.fetchCompanies {[weak self] (companies) in
            self?.companies = companies
            self?.tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    @objc func handleAddCompany(_ sender: Any){
        present(getCompanyModificationController(option: .create), animated: true, completion: nil)
    }
    
    @objc func handleResetCompany(_ sender: Any){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        var indexPaths = [IndexPath]()
        (0..<companies.count).forEach { (index) in
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        
        companies.removeAll()
        tableView.deleteRows(at: indexPaths, with: .left)
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do{
            try context.execute(batchDeleteRequest)
            tableView.reloadData()
        }catch let err{
            print("Failed to delete: ", err)
        }
    }
    
    func getCompanyModificationController(option: ModificationOption, for indexPath: IndexPath? = nil, company: Company? = nil)->RootNavigationController{
        let companyModificationController = CompanyModificationController(option: option, for: indexPath, company: company)
        companyModificationController.delegate = self
        
        let companyModificationNavigationController = RootNavigationController(rootViewController: companyModificationController)
        return companyModificationNavigationController
    }
}
