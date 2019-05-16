//
//  CompaniesController+UITableView.swift
//  Companies
//
//  Created by Hikaru Watanabe on 5/13/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

extension CompaniesController{
    //MARK:- TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employeesController = EmployeesController()
        employeesController.company = companies[indexPath.row]
        navigationController?.pushViewController(employeesController, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = "     Your Companies"
        header.backgroundColor = .lightBlue
        header.font = UIFont.boldSystemFont(ofSize: 20)
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .darkBlue
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
        cell.company = companies[indexPath.row]
        return cell
    }
}
