//
//  CompaniesController+CreateControllerDelegate.swift
//  Companies
//
//  Created by Hikaru Watanabe on 5/13/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit
extension CompaniesController: CompanyModificationControllerDelegate{
    func didAddCompany(company: Company) {
        self.companies.append(company)
        
        let indexPath = IndexPath(row: self.companies.count - 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    func didEditCompany(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
