//
//  CategoryViewController.swift
//  Todoey
//
//  Created by tony on 1/18/19.
//  Copyright © 2019 mekoo. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var catArray = [Category]()
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
    }

    //MARK-tabelViewDataSourceMethods
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
   
        cell.textLabel?.text = catArray[indexPath.row].name
        
        
        return cell
    }
    
   //MARK-tableDelegateMethods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let distinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            distinationVC.selectedCategory = catArray[indexPath.row]
        }
    }
    
    
    @IBAction func addCatButton(_ sender: UIBarButtonItem)
    {
        var textIt = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what will happen when user press the button
            
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textIt.text!
            self.catArray.append(newCategory)
            
            self.saveCategory()
            
        }
        
        alert.addTextField { (itemText) in
            itemText.placeholder = "Create new Category"
            textIt = itemText
        }
        alert.addAction(action)
        present(alert,animated: true)
    }
    func saveCategory() {
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    func loadCategory(with request : NSFetchRequest<Category>=Category.fetchRequest()) {
        
        do{
            catArray = try context.fetch(request)
        }catch{
            print("data didn't retrieved\(error)")
        }
        tableView.reloadData()
    }
    }
    

