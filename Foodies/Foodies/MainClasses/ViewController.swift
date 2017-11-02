//
//  ViewController.swift
//  Foodies
//
//  Created by Fhict on 27/09/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func changeViews(_ sender: Any) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            print(user)
            if Auth.auth().currentUser != nil {
                let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                let navController = UINavigationController(rootViewController: VC1)
                self.present(navController, animated:true, completion: nil)
                print("Hey")
                
            } else {
                
                let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "logInViewController") as! LoginViewController
                self.present(VC1, animated:true, completion: nil)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

