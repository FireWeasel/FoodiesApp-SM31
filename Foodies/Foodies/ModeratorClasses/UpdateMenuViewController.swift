//
//  UpdateMenuViewController.swift
//  Foodies
//
//  Created by Fhict on 31/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit

class UpdateMenuViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addVegBtn(_ sender: Any) {
        let popOverVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "addVegPopUp") as! AddVegetableViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @IBAction func addFruitBtn(_ sender: Any) {
        let popOverVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "fruitAddPopUp") as! AddFruitViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @IBAction func addMFBtn(_ sender: Any) {
        let popOverVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "addMFPopUp") as! AddMeatFishViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    @IBAction func addOtherBtn(_ sender: Any) {
        let popOverVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "addOtherPopUp") as! AddOtherViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }

}
