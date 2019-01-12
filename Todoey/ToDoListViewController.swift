//
//  ViewController.swift
//  Todoey
//
//  Created by tony on 1/12/19.
//  Copyright © 2019 mekoo. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var list = ["buy good","do anything","move on"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
//MARK-tabelViewDataSourceMethods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    //MARK-tableDelegateMethods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(list[indexPath.row])
        
      
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK-add new item
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textIt = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when user press the button
            self.list.append(textIt.text!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (itemText) in
            itemText.placeholder = "Create new item"
            textIt = itemText
        }
        alert.addAction(action)
        present(alert,animated: true)
    }
    
}

