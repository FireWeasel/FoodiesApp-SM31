//
//  UpdateRecipeViewController.swift
//  Foodies
//
//  Created by Fhict on 31/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UpdateRecipeViewController: UIViewController {

    @IBOutlet weak var httpTb: UITextView!
    @IBOutlet weak var titleTb: UITextField!
    @IBOutlet weak var ttpTb: UITextField!
    @IBOutlet weak var ingredientsTb: UITextView!
    var name:String?
    var ttP:String?
    var ingredients:String?
    var tips: String?
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        httpTb.text = tips
        titleTb.text = name
        ingredientsTb.text = ingredients
        ttpTb.text = ttP
    }

    @IBAction func updateBtn(_ sender: Any) {
        
        let recipeRef = ref.child("recipe").child(name!)
        let recipe = [
            "name":titleTb!.text,
            "timeToPrepare":ttpTb!.text,
            "ingredient":ingredientsTb!.text,
            "tips":httpTb!.text
        ]
        recipeRef.updateChildValues(recipe)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
}
