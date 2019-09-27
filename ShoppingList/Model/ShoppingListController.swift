//
//  ShoppingListController.swift
//  ShoppingList
//
//  Created by Michael Di Cesare on 9/27/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import Foundation
import CoreData



class ShoppingListController {
    // singleton
    static let shared = ShoppingListController()
    
    // Source of truth is becky the excitivuetive assistant
    var fetchedRequestController: NSFetchedResultsController<ShoppingList>
       init() {
           let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
               let foundItem = NSSortDescriptor(key: "foundItem", ascending: false)
               let shoppingItem = NSSortDescriptor(key: "shoppingItem", ascending: false)
           
           fetchRequest.sortDescriptors = [foundItem, shoppingItem]
           
           let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "foundItem", cacheName: nil)
           
           fetchedRequestController = resultsController
           do {
               try fetchedRequestController.performFetch()
           } catch {
               print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
           }
       }// end of becky
    
    // MARK: - Crud
    func add(shopppingItem: String, foundItem: Bool) {
        let _ = ShoppingList(foundItem: foundItem, shoppingItem: shopppingItem)
        saveToPersistentStore()
     
    }
    
    func update(shoppingList: ShoppingList, shoppingItem: String, foundItem: Bool) {
        shoppingList.shoppingItem = shoppingItem
        shoppingList.foundItem = foundItem
        saveToPersistentStore()
     
    }
    func remove(shoppingList: ShoppingList) {
        CoreDataStack.context.delete(shoppingList)
        saveToPersistentStore()
      
    }
    func toggleIsCompleteFor(shoppingList: ShoppingList) {
        shoppingList.foundItem.toggle()
        saveToPersistentStore()
    }
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    
    
    
    
    
}//end of class

