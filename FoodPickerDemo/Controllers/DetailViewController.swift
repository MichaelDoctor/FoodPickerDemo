//
//  DetailViewController.swift
//  FoodPickerDemo
//
//  Created by Michael Doctor on 2021-04-11.
//

import UIKit

class DetailViewController: UIViewController {
    // passed from ViewController
    var item: FoodItem?
    
    // use context to keep track of Core Data. Essentially how we can manipulate our persisted data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the title of nav to the name of the item
        title = item?.name!
    }
}

//MARK: - Buttons

extension DetailViewController {
    @IBAction func editPressed(_ sender: UIButton) {
        // create an alert popup
        let alert = UIAlertController(title: "Edit", message: "Update \(item?.name! ?? "item")", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.text = item?.name
        alert.addAction(UIAlertAction(title: "Submit", style: .default){
            // creates a weak reference to self (DetailViewController) to avoid retain cycles
            [weak self] _ in
            // like if-let, guard let also unwraps optionals if they contain a value. In guard let, if the check fails, guard-let will exit the current function,loop or condition.
            guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else { return }
            // only runs this if all guard let statements pass the check
            self?.updateItem(item: (self?.item)! , newName: newName)
            self?.title = newName
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    // Reference created from Main.storyBoard
    @IBAction func deletePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete '\(item?.name! ?? "item")'?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive){
            [weak self] _ in
            self?.deleteItem(item: (self?.item)!)
            // Redirect to ViewController
            self?.navigationController?.popToRootViewController(animated: true)
        })
        present(alert, animated: true)
    }
}

//MARK: - Core Data functions

extension DetailViewController {
    func updateItem(item: FoodItem, newName: String) {
        item.name = newName
        
        do {
            try context.save()
            
        } catch {
            print("updateItem Error")
        }
    }
    
    func deleteItem(item: FoodItem) {
        context.delete(item)
        
        do {
            try context.save()
        } catch {
            print("deleteItem Error")
        }
    }
}
