//
//  MenuViewController.swift
//  Foodies
//
//  Created by Fhict on 04/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class MenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var handle: AuthStateDidChangeListenerHandle?
    @IBOutlet weak var leadingConstrain: NSLayoutConstraint!
    var menuShowing = false
    var ref: DatabaseReference!
    var refHandle:UInt!
    var recipes = [Recipe]()
    var favRecipes = [Recipe]()
    @IBOutlet weak var tableViewFavProduct: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        //getData()
        getRecipes()
    }
    @IBAction func openMenu(_ sender: Any) {
        if(menuShowing)
        {
            leadingConstrain.constant = -144
        }
        else
        {
            leadingConstrain.constant = 0
        }
        menuShowing = !menuShowing
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath)
       // cell.nameLabel?.text = meats[indexPath.row].name
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
    func getRecipes()
    {
        refHandle = ref.child("recipe").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let recipe = Recipe()
                recipe.setValuesForKeys(dictionary)
                self.recipes.append(recipe)
                /*for(key,value) in recipes{
                    if(value)
                    {
                        favRecipes.append()
                    }
                }*/
                DispatchQueue.main.async {
                    self.tableViewFavProduct.reloadData()
                }
            }
        })
    }
}
