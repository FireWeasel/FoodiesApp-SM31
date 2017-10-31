//
//  AddOtherViewController.swift
//  Foodies
//
//  Created by Fhict on 31/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddOtherViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    @IBOutlet weak var nameTb: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addBtn(_ sender: Any) {
        self.ref.child("other").child(nameTb!.text!).setValue(["name": nameTb!.text])
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}
