//
//  RecipeViewController.swift
//  Foodies
//
//  Created by Fhict on 31/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RecipeViewController: UIViewController {

    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var ttPLB: UILabel!
    @IBOutlet weak var ingredientsTB: UITextView!
    @IBOutlet weak var tipsTB: UITextView!
    var refHandle:UInt!
    var name:String!
    var ttP:String?
    var ingredients:String?
    var tips:String?
    var imageForRecipe:String?
    var ref: DatabaseReference!
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.nameLB.text = name
        //self.ttPLB.text = ttP
        //self.ingredientsTB.text = ingredients
        //self.tipsTB.text = tips
        nameLB.preferredMaxLayoutWidth = 150
        ref = Database.database().reference()
        loadImage()
        loadRecipe(name: self.name!)
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
                controller.img = self.imageRecipe.image
            }
        }
    func loadImage(){
        print(imageForRecipe)
        if let recipeImageUrl = imageForRecipe {
            let url = URL(string: recipeImageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data,response ,error ) in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    self.imageRecipe?.image = UIImage(data:data!)
                }
            }).resume()
        }
    }
    func loadRecipe(name: String){
            refHandle = ref.child("recipe").child(name).observe(.childAdded, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    let recipe = Recipe()
                    recipe.setValuesForKeys(dictionary)
                    self.recipes.append(recipe)
                    self.ingredients = recipe.ingredient
                    self.ttP = recipe.timeToPrepare
                    self.tips = recipe.tips
                }
            })
        nameLB.text = name
        ingredientsTB.text = self.ingredients
        ttPLB.text = self.ttP
        tipsTB.text = self.tips
    }
}
