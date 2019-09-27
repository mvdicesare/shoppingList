//
//  CoreDataStack.swift
//  ShoppingList
//
//  Created by Michael Di Cesare on 9/27/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {

static let container: NSPersistentContainer = {

    let appName = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
    let container = NSPersistentContainer(name: "ShoppingList")
    container.loadPersistentStores() { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    return container
}()

static var context: NSManagedObjectContext { return container.viewContext }
}

