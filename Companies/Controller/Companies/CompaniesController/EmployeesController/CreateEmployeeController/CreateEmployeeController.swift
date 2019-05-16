//
//  CreateEmployeeControlller.swift
//  Companies
//
//  Created by Hikaru Watanabe on 5/14/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit
import CoreData



class CreateEmployeeController: UIViewController {
    var createEmployeeView: CreateEmpoyeeView!
    var delegate: CreateEmployeeControllerDelegate?
    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    fileprivate func setup(){
        view.backgroundColor = .lightBlue
        
        createEmployeeView = CreateEmpoyeeView(frame: .zero)
        createEmployeeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createEmployeeView)
        NSLayoutConstraint.activate([
            createEmployeeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            createEmployeeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            createEmployeeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            createEmployeeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        
        navigationItem.title = "CreateEmployee"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
    }
    
    @objc fileprivate func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSave(){
        guard let employeeName = createEmployeeView.nameTextField.text, let company = company else{
            return
        }
        
        guard let bdText = createEmployeeView.birthdayTextField.text else{
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        guard let birthday = dateFormatter.date(from: bdText) else{
            present(UIAlertController.errorMessage(header: "Failed to add employee", message: "Please enter the employee's birthday"), animated: true, completion: nil)
            return
        }
        
        CoreDataManager.shared.createEmployee(name: employeeName, company: company, birthday: birthday) {[weak self] (employee) in
            if let employee = employee{
                self?.dismiss(animated: true, completion: {
                    self?.delegate?.didAddEmployee(employee: employee)
                })
            }else{
                self?.present(UIAlertController.errorMessage(header: "Failed to add employee", message: "Something went wrong while adding employee..."), animated: true, completion: nil)
            }
        }
    }
}
