//
//  AddRecipeViewController.swift
//  Foodies
//
//  Created by Fhict on 31/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddRecipeViewController: UIViewController {

    @IBOutlet weak var titleTb: UITextField!
    @IBOutlet weak var ttpTb: UITextField!
    @IBOutlet weak var ingredientsTb: UITextView!
    @IBOutlet weak var hTPTb: UITextView!
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func createBtn(_ sender: Any) {
        let name = titleTb!.text
        print (name)
        let recipe =
            [
                "name": titleTb!.text,
                "timeToPrepare": ttpTb!.text,
                "ingredient": ingredientsTb!.text,
                "tips": hTPTb!.text
        ]
        
        print (recipe)
        self.ref.child("recipe").child(name!).setValue(recipe)
        titleTb.text = ""
        ttpTb.text = ""
        ingredientsTb.text = ""
        hTPTb.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
}
