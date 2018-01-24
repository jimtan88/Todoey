//
//  ViewController.swift
//  Todoey
//
//  Created by Jwu Jiun Tan on 15/1/18.
//  Copyright © 2018 Aurumusica. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Buy Eggs", "Pay Credit Cards", "Copy music for student"]
    
    let defaults = UserDefaults.standard  //this "default" saves data into device memory
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //this statement loads saved data from device memory.
        //the "let item" part catches possible error, such as file not exist yet
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
      //let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: IndexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Create tableView delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(indexPath.row): \(itemArray[indexPath.row])")
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: Add item
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //things to happen when "Add Item" button is clicked
            
            print("Success! \(textField.text!)")
            
            self.itemArray.append(textField.text!)
            //save data
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

