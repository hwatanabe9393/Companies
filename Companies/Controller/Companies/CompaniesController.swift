//
//  CompaniesController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController, CompanyModificationControllerDelegate {
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
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do{
            self.companies = try context.fetch(fetchRequest)
            tableView.reloadData()
        }catch let error{
            print("Failed to fetch companies: \(error)")
        }
        
    }
    
    @objc func handleAddCompany(_ sender: Any){
        present(getCompanyModificationController(option: .create), animated: true, completion: nil)
    }
    
    fileprivate func getCompanyModificationController(option: ModificationOption, for indexPath: IndexPath? = nil, company: Company? = nil)->RootNavigationController{
        let companyModificationController = CompanyModificationController(option: option, for: indexPath, company: company)
        companyModificationController.delegate = self
        
        let companyModificationNavigationController = RootNavigationController(rootViewController: companyModificationController)
        return companyModificationNavigationController
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: deleteActionHandler)
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editActionHandler)
        editAction.backgroundColor = .darkBlue
        return [deleteAction, editAction]
    }
    
    fileprivate func deleteActionHandler(action: UITableViewRowAction, indexPath: IndexPath){
        //remove the company from our tableview
        let removedCompany = self.companies.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        //remove from coredata
        let context = CoreDataManager.shared.persistentContainer.viewContext
        context.delete(removedCompany)
        do{
            try context.save()
        }catch let error{
            print("Failed to delete company: ", error)
        }
    }
    
    fileprivate func editActionHandler(action: UITableViewRowAction, indexPath: IndexPath){
        present(getCompanyModificationController(option: .edit, for: indexPath, company: companies[indexPath.row]), animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: companyCellId, for: indexPath) as! CompanyCell
        var text = ""
        if let name = companies[indexPath.row].name{
            text += name
        }
        if let founded = companies[indexPath.row].founded{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let date = dateFormatter.string(from: founded)
            text += " - \(date)"
        }
        
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .tealColor
        return cell
    }
}

//MARK:- CompanyModificationController
extension CompaniesController{
    func didAddCompany(company: Company) {
        self.companies.append(company)
        
        let indexPath = IndexPath(row: self.companies.count - 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    func didEditCompany(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
