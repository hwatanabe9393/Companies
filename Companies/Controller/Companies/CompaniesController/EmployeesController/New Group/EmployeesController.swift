//
//  EmployeesController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 5/14/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class EmployeesController: UITableViewController {
    var company: Company?
    var employees: [Employee]?
    let cellId = "cellId"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setup()
        fetchEmployees()
    }
    
    fileprivate func setup(){
        navigationItem.title = company?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        
        tableView.backgroundColor = .darkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    @objc fileprivate func handleAdd(){
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.delegate = self
        createEmployeeController.company = company
        let navController = RootNavigationController(rootViewController: createEmployeeController)
        present(navController, animated: true, completion: nil)
    }
    
    private func fetchEmployees(){
        if let employees = company?.employees?.allObjects as? [Employee]{
            self.employees = employees
        }else{
            employees = [Employee]()
        }
    }
}

//MARK:- TableView delegate and datasource
extension EmployeesController{
    override func numberOfSections(in tableView: UITableView)->Int{
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        
        
        if let employees = employees{
            let employee = employees[indexPath.row]
            let name = employee.name ?? "N/A"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            var birthday = "MM/dd/yyyy"
            if let bd = employee.employeeInformation?.birthday{
                birthday = dateFormatter.string(from: bd)
            }
            
            cell.textLabel?.text = "\(name)    \(birthday)"
        }
        
        cell.backgroundColor = .tealColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        return cell
    }
}

extension EmployeesController: CreateEmployeeControllerDelegate{
    func didAddEmployee(employee: Employee) {
        DispatchQueue.main.async {[weak self] in
            self?.employees?.append(employee)
            self?.tableView.reloadData()
        }
    }
}
