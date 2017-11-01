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

class LogInPopUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var passTb: UITextField!
    @IBOutlet weak var emailTb: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTb.delegate = self
        self.passTb.delegate = self
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            emailTb.resignFirstResponder()
            passTb.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    @IBAction func logInBtn(_ sender: Any) {
        let email = emailTb.text
        let password = passTb.text
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            
            if error == nil {
                print("You have successfully logged in")
                /*let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                self.navigationController!.pushViewController(vc, animated: true)*/
                let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
                let navController = UINavigationController(rootViewController: VC1)
                self.present(navController, animated:true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
