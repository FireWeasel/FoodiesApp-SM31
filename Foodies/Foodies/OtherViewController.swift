//
//  OtherViewController.swift
//  Foodies
//
//  Created by Fhict on 30/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class OtherViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    @IBOutlet weak var tableViewProduct: UITableView!
    var index:Int = 0
    var others = [Other]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getOthers()
        tableViewProduct.delegate = self
        tableViewProduct.dataSource = self
        
    }
    
    func getOthers(){
        refHandle = ref.child("other").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let other = Other()
                other.setValuesForKeys(dictionary)
                self.others.append(other)
                DispatchQueue.main.async {
                    self.tableViewProduct.reloadData()
                }
            }
        })
    }
    @IBAction func buttonHandlerAddToCart(_ sender: UIButton) {
        
        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: self.tableViewProduct)
        
        let indexPath = self.tableViewProduct.indexPathForRow(at: buttonPosition)!
        
        let cell = tableViewProduct.cellForRow(at: indexPath) as! ProductCell
        
        let imageViewPosition : CGPoint = cell.imageViewProduct.convert(cell.imageViewProduct.bounds.origin, to: self.view)
        
        
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.imageViewProduct.frame.size.width, height: cell.imageViewProduct.frame.size.height))
        
        imgViewTemp.image = cell.imageViewProduct.image
        
        animation(tempView: imgViewTemp)
        
        self.ref.child("list").child(cell.nameLabel!.text!).setValue(["name": cell.nameLabel?.text])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return others.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath) as! ProductCell
        cell.nameLabel?.text = others[indexPath.row].name
        return cell
    }
    
    func animation(tempView : UIView)  {
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 0.5,
                       animations: {
                        tempView.animationZoom(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
                tempView.animationRoted(angle: CGFloat(Double.pi))
                
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
            })
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
    }

}
