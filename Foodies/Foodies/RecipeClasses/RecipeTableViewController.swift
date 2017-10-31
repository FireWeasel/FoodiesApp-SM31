//
//  RecipeTableViewController.swift
//  Foodies
//
//  Created by Fhict on 29/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RecipeTableViewController: UITableViewController {

    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    var index:Int = 0
    var recipes = [Recipe]()
    var colors = [UIColor]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        getRecipes()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath) as! RecipeCell
        cell.nameLabel?.text = recipes[indexPath.row].name
        cell.ttPLabel?.text = recipes[indexPath.row].timeToPrepare
        cell.backgroundColor = UIColor.lightGray
        cell.nameLabel?.textColor = UIColor.white
        cell.ttPLabel?.textColor = UIColor.white
       
        return cell
    }
    
    func getRecipes()
    {
        refHandle = ref.child("recipe").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let recipe = Recipe()
                recipe.setValuesForKeys(dictionary)
                self.recipes.append(recipe)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! RecipeViewController
                let value = recipes[indexPath.row]
                let cell = tableView.cellForRow(at: indexPath) as! RecipeCell
                controller.name = cell.nameLabel?.text
                controller.ttP = cell.ttPLabel?.text
                controller.ingredients = value.ingredient
                controller.tips = value.tips
            }
        }
    }
}
