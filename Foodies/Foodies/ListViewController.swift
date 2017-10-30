//
//  ListViewController.swift
//  Foodies
//
//  Created by Fhict on 30/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    var refHandle:UInt!
    var index:Int = 0
    var lists = [List]()
    @IBOutlet weak var tableViewProduct: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        getList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath) as! ListCell
        cell.nameLabel?.text = lists[indexPath.row].name
        return cell
    }
    
    func getList(){
        
        refHandle = ref.child("list").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let list = List()
                list.setValuesForKeys(dictionary)
                self.lists.append(list)
                print(list)
                DispatchQueue.main.async {
                    self.tableViewProduct.reloadData()
                }
            }
        })
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
        }
    }
}
