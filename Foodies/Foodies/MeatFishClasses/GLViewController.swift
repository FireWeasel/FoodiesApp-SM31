//
//  GLViewController.swift
//  Foodies
//
//  Created by Fhict on 12/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class GLViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    var meats = [Meat]()
    
    @IBOutlet weak var tableViewProduct: UITableView!
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        getMeats()
        tableViewProduct.delegate = self
        tableViewProduct.dataSource = self
        self.tableViewProduct.estimatedRowHeight = 100
        self.hideKeyboardWhenTappedAround()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meats.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath) as! ProductCell
        cell.nameLabel?.text = meats[indexPath.row].name
        let meat = meats[indexPath.row]
        if let meatImageUrl = meat.imageItem {
            let url = URL(string: meatImageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data,response ,error ) in
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    cell.imageViewProduct?.image = UIImage(data: data!)
                }
            }).resume()
        }
        return cell
    }
    
    func getMeats()
    {
        refHandle = ref.child("meat").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let meat = Meat()
                meat.setValuesForKeys(dictionary)
                self.meats.append(meat)
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
        let list =
            [
                "name": cell.nameLabel?.text,
                "quantity": cell.quantityLb!.text
        ]
        
        self.ref.child("list").child(cell.nameLabel!.text!).setValue(list)
        cell.quantityLb?.text = ""
        
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
extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
};
