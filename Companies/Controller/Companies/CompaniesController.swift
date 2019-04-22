//
//  CompaniesController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CreateCompanyControllerDelegate {
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "reset", style: .plain, target: self, action: #selector(handleAddCompany(_:)))
    }
    
    fileprivate func fetchCompanies(){
        // Initialization core data stack
        let persistentContainer = NSPersistentContainer(name: "CompaniesModels")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error{
                fatalError("Loading of store failed: \(error)")
            }
        })
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do{
            self.companies = try context.fetch(fetchRequest)
            tableView.reloadData()
        }catch let error{
            print("Failed to fetch companies: \(error)")
        }
        
    }
    
    @objc func handleAddCompany(_ sender: Any){
        let createCompanyController = CreateCompanyController()
        createCompanyController.delegate = self
        
        let createCompanyNavigationController = RootNavigationController(rootViewController: createCompanyController)
        present(createCompanyNavigationController, animated: true, completion: nil)
    }
    
    @objc func handleResetCompany(_ sender: Any){
        //TODO:- Reset company
    }
    
    
    
    //MARK:- CreateCompanyController
    func didAddCompany(company: Company) {
        self.companies.append(company)
        
        let indexPath = IndexPath(row: self.companies.count - 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .fade)
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
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .tealColor
        return cell
    }
}
