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
import FirebaseStorage

class UpdateRecipeViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var httpTb: UITextView!
    @IBOutlet weak var titleTb: UITextField!
    @IBOutlet weak var ttpTb: UITextField!
    @IBOutlet weak var ingredientsTb: UITextView!
    var name:String?
    var ttP:String?
    var ingredients:String?
    var tips: String?
    var img:UIImage?
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        httpTb.text = tips
        titleTb.text = name
        ingredientsTb.text = ingredients
        ttpTb.text = ttP
        
        self.titleTb.delegate = self
        self.httpTb.delegate = self
        self.ttpTb.delegate = self
        self.ingredientsTb.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func addImageBtn(_ sender: Any) {
        openPhotoLibrary()
    }
    
    func openPhotoLibrary(){
        let imagePicker = UIImagePickerController()
        present(imagePicker,animated:true,completion: nil)
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var selectedImage:UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        {
            selectedImage = editedImage
        }   else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = originalImage
        }
        
        if let selectedImageFromPicker = selectedImage  {
            self.image = selectedImageFromPicker
        }
        picker.dismiss(animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
        
        print("did cancel")
    }

    @IBAction func updateBtn(_ sender: Any) {
        let name = titleTb!.text
        let oldName = self.name
        let timeToPrepare = ttpTb!.text
        let ingredient = ingredientsTb!.text
        let tips = httpTb!.text
        print(name)
        print(timeToPrepare)
        print(ingredient)
        print(tips)
        
        let refImage = Storage.storage().reference().child("Recipe").child("\(name!).jpg")
        if image == nil {
            image = img
        }
        else {
            return
        }
        if let uploadData = UIImagePNGRepresentation(self.image!)
        {
            refImage.putData( uploadData , metadata: nil, completion: { (metadata, error) in
                if error != nil
                {
                    print(error)
                    return
                }
                if let productImageURL = metadata?.downloadURL()?.absoluteString {
                    let value = [
                        "name" : name,
                        "imageItem" : productImageURL,
                        "ingredient": ingredient,
                        "tips": tips,
                        "timeToPrepare": timeToPrepare
                        ] as [String : Any]
                    self.saveProductIntoDatabase(name: oldName!, value: value)
                }
            })
        }
    }
    
    private func saveProductIntoDatabase(name:String,value:[String:Any])
    {
        let recipeRef = ref.child("recipe").child(name)
        recipeRef.updateChildValues(value)
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
