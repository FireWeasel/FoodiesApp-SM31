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
import FirebaseStorage

class AddOtherViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    var image:UIImage?
    
    @IBOutlet weak var nameTb: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        ref = Database.database().reference()
        self.nameTb.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            nameTb.resignFirstResponder()
            return false
        }
        return true
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addBtn(_ sender: Any) {
        let name = nameTb!.text
        
        if image == nil {
            image = #imageLiteral(resourceName: "fruits-75a")
        }
        else {
            //return
        }
        
        let refImage = Storage.storage().reference().child("Other").child("\(name!).jpg")
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
                        "imageItem" : productImageURL
                        ] as [String : Any]
                    self.saveProductIntoDatabase(name: name!, value: value)
                }
            })
        }
        nameTb.text = ""
        self.view.removeFromSuperview()
    }
    
    private func saveProductIntoDatabase(name: String, value: [String:Any])
    {
        self.ref.child("other").child(name).setValue(value)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.view.removeFromSuperview()
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
