//
//  ListTableViewController.swift
//  Foodies
//
//  Created by Fhict on 30/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ListTableViewController: UITableViewController {

    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    var index:Int = 0
    var lists = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //refreshControl = UIRefreshControl()
        //refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        //refreshControl?.addTarget(self, action: "refresh:", for: UIControlEvents.valueChanged)
        //self.tableView?.addSubview(refreshControl!)
        ref = Database.database().reference()
        getList()
    }

    /*func refresh(sender:UIRefreshControl)
    {
        refreshControl!.addTarget(self, action: "getList", for: UIControlEvents.valueChanged)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath) as! LIstCell
        cell.nameLabel?.text = lists[indexPath.row].name
        cell.quantityLabel?.text = lists[indexPath.row].quantity
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }
    
    @IBAction func removeItem(_ sender: UIButton) {
        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)!
        let cell = tableView.cellForRow(at: indexPath) as! LIstCell
        ref.child("list").child(cell.nameLabel!.text!).removeValue()
        sender.isSelected = !sender.isSelected
        
    }

    func getList()
    {
        refHandle = ref.child("list").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let list = List()
                list.setValuesForKeys(dictionary)
                self.lists.append(list)
                
               // if (self.refreshControl?.isRefreshing)!
                //{
                 //   self.refreshControl?.endRefreshing()
                //}
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
   override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
}
