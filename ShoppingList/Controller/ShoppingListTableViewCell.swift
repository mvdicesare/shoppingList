//
//  ShoppingListTableViewCell.swift
//  ShoppingList
//
//  Created by Michael Di Cesare on 9/27/19.
//  Copyright © 2019 Michael Di Cesare. All rights reserved.
//



import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    @IBOutlet weak var shoppingItem: UILabel!
    
    @IBOutlet weak var completeLabel: UIButton!
    
    
    @IBAction func completeButtonPressed(_ sender: Any) {
        delegate?.buttonCellTapped(self)
    }
    weak var delegate: shoppingListTableViewCellDelegate?
    
    func updateButton(_ isComplete: Bool) {
        if isComplete {
            completeLabel.setTitle("☑️", for: .normal)
        } else {
            completeLabel.setTitle("⬜️", for: .normal)
        }
        
        
    }
    
} // end of class

extension ShoppingListTableViewCell {
    func update(withPress shoppingList: ShoppingList) {
        shoppingItem.text = shoppingList.shoppingItem
        updateButton(shoppingList.foundItem)
       
        
    }
    
}


protocol shoppingListTableViewCellDelegate: class {
    func buttonCellTapped(_ sender: ShoppingListTableViewCell)
}
