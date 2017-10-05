//
//  MenuViewController.swift
//  Foodies
//
//  Created by Fhict on 04/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var leadingConstrain: NSLayoutConstraint!
    var menuShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
