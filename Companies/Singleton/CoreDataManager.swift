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
}
