//
//  ShoppingList+Convinease.swift
//  ShoppingList
//
//  Created by Michael Di Cesare on 9/27/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import Foundation
import CoreData


extension ShoppingList {
    convenience init(foundItem: Bool = false, shoppingItem: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.foundItem = foundItem
        self.shoppingItem = shoppingItem
    }
}
