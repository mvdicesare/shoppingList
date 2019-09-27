//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Michael Di Cesare on 9/27/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListTableViewController: UITableViewController, shoppingListTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppingListController.shared.fetchedRequestController.delegate = self
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add New Shoping Item", message: "", preferredStyle: .alert)
            
            let addItem = UIAlertAction(title: "Add", style: .default) { (action) in
                guard let newItem = alert.textFields?[0].text else {return}
                ShoppingListController.shared.add(shopppingItem: newItem, foundItem: false)
            }
            
            let cancleButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            alert.addTextField { (_) in
            }
            alert.addAction(addItem)
            alert.addAction(cancleButton)
            self.present(alert, animated: true)
        }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ShoppingListController.shared.fetchedRequestController.sectionIndexTitles[section] == "1" ? "Not Found" : "Located"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return ShoppingListController.shared.fetchedRequestController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ShoppingListController.shared.fetchedRequestController.sections?[section].numberOfObjects ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let shoppingList = ShoppingListController.shared.fetchedRequestController.object(at: indexPath)
        cell.update(withPress: shoppingList)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let shoppingList = ShoppingListController.shared.fetchedRequestController.object(at: indexPath)
            ShoppingListController.shared.remove(shoppingList: shoppingList)
        }
    }
    
    func buttonCellTapped(_ sender: ShoppingListTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let shoppingList = ShoppingListController.shared.fetchedRequestController.object(at: indexPath)
        ShoppingListController.shared.toggleIsCompleteFor(shoppingList: shoppingList)
        sender.update(withPress: shoppingList)
    }

    

} // end of class
// MARK: - Extension
extension ShoppingListTableViewController: NSFetchedResultsControllerDelegate {
    // Conform to the NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    //sets behavior for cells
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }

        
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
}
