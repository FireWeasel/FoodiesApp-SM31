//
//  PopUpViewController.swift
//  Foodies
//
//  Created by Fhict on 26/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInPopUpViewController: UIViewController {

    @IBOutlet weak var passTb: UITextField!
    @IBOutlet weak var emailTb: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func logInBtn(_ sender: Any) {
        let email = emailTb.text
        let password = passTb.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            
            if error == nil {
                print("You have successfully logged in")
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
