//
//  GLViewController.swift
//  Foodies
//
//  Created by Fhict on 12/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit

class GLViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewProduct: UITableView!
    //var fruits = [Fruit]()
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProduct.delegate = self
        tableViewProduct.dataSource = self
        
        //test on getting json data
        guard let path = Bundle.main.path(forResource: "Products", ofType: "json") else {return}
        let url = URL(fileURLWithPath: path)
        
        
        do{
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            //testing printing data
            print(json)
            
            guard let array = json as? [Any] else {return}
            
            for fruit in array {
                guard let userDict = fruit as? [String: Any] else {return}
                guard let userId = userDict["id"] as? Int else {print("not an int"); return}
                guard let name = userDict["name"] as? String else {return}
                guard let price = userDict["price"] as? Double else {print("not an Double"); return}
                
                print(userId)
                print(name)
                print(price)
        }
            }catch {
                print(error)
        }
        
        //force unwraping since we know the file will work
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    //MARK: TableView Delegate method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath) as! ProductCell
        
        
        return cell
    }
    
    
    @IBAction func buttonHandlerAddToCart(_ sender: UIButton) {
        
        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: self.tableViewProduct)
        
        let indexPath = self.tableViewProduct.indexPathForRow(at: buttonPosition)!
        
        let cell = tableViewProduct.cellForRow(at: indexPath) as! ProductCell
        
        let imageViewPosition : CGPoint = cell.imageViewProduct.convert(cell.imageViewProduct.bounds.origin, to: self.view)
        
        
        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.imageViewProduct.frame.size.width, height: cell.imageViewProduct.frame.size.height))
        
        imgViewTemp.image = cell.imageViewProduct.image
        
        animation(tempView: imgViewTemp)
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
                
                /* UIView.animate(withDuration: 1.0, animations: {
                 
                 })*/
                
            })
            
        })
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
