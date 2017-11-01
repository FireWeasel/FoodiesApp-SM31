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

class MenuViewController: UIViewController {

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "firstViewController") as! ViewController
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
        }
    }
}
