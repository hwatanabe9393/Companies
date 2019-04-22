//
//  CreateCompanyController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
    var delegate: CreateCompanyControllerDelegate?
    
    fileprivate var createCompanyView: CreateCompanyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    fileprivate func setup(){
        //NavBar
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        
        //Views
        view.backgroundColor = .lightBlue
        setLayout()
    }
    
    fileprivate func setLayout(){
        createCompanyView = CreateCompanyView()
        createCompanyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createCompanyView)
        
        NSLayoutConstraint.activate([
            createCompanyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            createCompanyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            createCompanyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            createCompanyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave(){
        dismiss(animated: true){[weak self] in
            if let name = self?.createCompanyView.nameTextField.text, name.count > 0{
                let company = Company(name: name, founded: Date())
                self?.delegate?.didAddCompany(company: company)
            }
        }
    }
    
}
