//
//  CreateCompanyController.swift
//  Companies
//
//  Created by Hikaru Watanabe on 4/21/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit
import CoreData

enum ModificationOption{
    case create, edit
}

class CompanyModificationController: UIViewController {
    
    fileprivate let option: ModificationOption
    fileprivate var company: Company?
    fileprivate let indexPath: IndexPath?
    
    var delegate: CompanyModificationControllerDelegate?
    fileprivate var companyModificationView: CompanyModificationView!
    
    ///This initializer must be used for initializing this class. For editing option, non-nil company must be passed.
    required init(option: ModificationOption, for indexPath: IndexPath? = nil , company: Company? = nil){
        if option == .create && company != nil{
            fatalError("For creating CompanyModificationController, non-nil copmany must be passed but received nil.")
        }
        if option == .edit && (indexPath == nil || company == nil){
            fatalError("For editing CompanyModificationController, nil copmany must be passed but received non-nil.")
        }
        self.option = option
        self.company = company
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    fileprivate func setup(){
        //NavBar
        navigationItem.title = option == .create ? "Create Company" : "Edit Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        
        //Views
        view.backgroundColor = .lightBlue
        setLayout()
        
        //Company name if edit
        if option == .edit{
            companyModificationView.nameTextField.text = company?.name ?? ""
        }
    }
    
    fileprivate func setLayout(){
        companyModificationView = CompanyModificationView()
        companyModificationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(companyModificationView)
        
        NSLayoutConstraint.activate([
            companyModificationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            companyModificationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            companyModificationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            companyModificationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSave(){
        dismiss(animated: true){[weak self] in
            guard let name = self?.companyModificationView.nameTextField.text else{
                return
            }
            let context = CoreDataManager.shared.persistentContainer.viewContext
            if self?.option == .create{
                guard let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context) as? Company else{
                    return
                }
                company.setValue(name, forKey: "name")
                //Perform core data save
                do{
                    try context.save()
                    self?.delegate?.didAddCompany(company: company)
                }catch let error{
                    print("Error while saving CD: \(error)")
                }
            }else if self?.option == .edit{
                self?.company?.setValue(name, forKey: "name")
                do{
                    try context.save()
                    if let indexPath = self?.indexPath{
                        self?.delegate?.didEditCompany(indexPath: indexPath)
                    }
                }catch let error{
                    print("Error while update edit:",error)
                }
            }
        }
    }
    
}
