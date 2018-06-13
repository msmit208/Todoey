//
//  ViewController.swift
//  Todoey
//
//  Created by Michael Smith on 6/4/18.
//  Copyright © 2018 RAW Intelligence. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard //in order to use user defaults a new object had to be made.

    //MARK: - User defaults in ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        } // in order to retrieve data from userdefauls upon relaunching off app so no data is terminated.
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    //MARK: - TableVew Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row]) //this will print out the corresponding item in the index row.
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } // this conditional allows a checkmark to either appear/disappear depending on whats selected.
        
        tableView.deselectRow(at: indexPath, animated: true) //shows you selected a row and then deselects itself.
    }
    
    //MARK: - ADD NEW ITEMS
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert.
            
            self.itemArray.append(textField.text!) //you can force unwrap because the text property of a textfield will never equal nil
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray") // this saves the updated itemArray to the user defaults using the key "TodoListArray" making it a dictionary. remember this code is inside a closure hence the need for the self. at the beginning of the code.
            
            self.tableView.reloadData() //updates and adds new data to array.
            
        }//this is the button you press after you have finished creating your todo list item.
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

