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
import FirebaseStorage

class AddRecipeViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTb: UITextField!
    @IBOutlet weak var ttpTb: UITextField!
    @IBOutlet weak var ingredientsTb: UITextView!
    @IBOutlet weak var hTPTb: UITextView!
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.titleTb.delegate = self
        self.ttpTb.delegate = self
        self.ingredientsTb.delegate = self
        self.hTPTb.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func createBtn(_ sender: Any) {
        let name = titleTb!.text
        let timeToPrepare = ttpTb!.text
        let ingredient = ingredientsTb!.text
        let tips = hTPTb!.text
        
        if image == nil {
            image = #imageLiteral(resourceName: "fruits-75a")
        }
        else {
            return
        }
        
        let refImage = Storage.storage().reference().child("Recipe").child("\(name!).jpg")
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
                    self.saveProductIntoDatabase(name: name!, value: value)
                }
            })
        }
        titleTb.text = ""
        ttpTb.text = ""
        ingredientsTb.text = ""
        hTPTb.text = ""
    }
    
    private func saveProductIntoDatabase(name:String,value:[String:Any])
    {
        self.ref.child("recipe").child(name).setValue(value)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    @IBAction func addItemBtn(_ sender: Any) {
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
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
