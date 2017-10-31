//
//  RecipeViewController.swift
//  Foodies
//
//  Created by Fhict on 31/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var ttPLB: UILabel!
    @IBOutlet weak var ingredientsTB: UITextView!
    @IBOutlet weak var tipsTB: UITextView!
    var name:String?
    var ttP:String?
    var ingredients:String?
    var tips:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLB.text = name
        self.ttPLB.text = ttP
        self.ingredientsTB.text = ingredients
        self.tipsTB.text = tips
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
                let controller = segue.destination as! UpdateRecipeViewController
                controller.name = self.nameLB?.text
                controller.ttP = self.ttPLB?.text
                controller.ingredients = self.ingredientsTB?.text
                controller.tips = self.tipsTB?.text
            }
        }
    }
