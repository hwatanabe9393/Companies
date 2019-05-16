//
//  CoreDataManager.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/23/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager{
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        // Initialization core data stack
        let persistentContainer = NSPersistentContainer(name: "CompaniesModels")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error{
                fatalError("Loading of store failed: \(error)")
            }
        })
        return persistentContainer
    }()
    
    func fetchCompanies(completionHandler: @escaping ([Company])->()){
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        do{
            let companies = try context.fetch(fetchRequest)
            completionHandler(companies)
        }catch let error{
            print("Failed to fetch companies: \(error)")
        }
    }
    
    func createEmployee(name: String, company: Company, birthday: Date, completionHandler: @escaping (Employee?)->()){
        let context = persistentContainer.viewContext
        
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        employee.setValue(name, forKey: "name")
        
        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
        employeeInformation.taxId = "001"
        employeeInformation.birthday = birthday
        
        employee.company = company
        employee.employeeInformation = employeeInformation
        
        do{
            try context.save()
            completionHandler(employee)
        }catch let err{
            print("Failed to create employee: ", err)
            completionHandler(nil)
        }
    }
    
    func fetchEmployees(completionHandler: @escaping ([Employee])->()){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        do{
            let employees = try context.fetch(request)
            completionHandler(employees)
        }catch let err{
            print("Failed to fetch employees: ", err)
        }
    }
}
