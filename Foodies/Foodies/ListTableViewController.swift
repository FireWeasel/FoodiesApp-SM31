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

        ref = Database.database().reference()
        getList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for:indexPath)
        cell.textLabel?.text = lists[indexPath.row].name
        print(lists[indexPath.row].name)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
        let cell = tableView.cellForRow(at: indexPath) as! ProductCell
        ref.child("list").child(cell.textLabel!.text!).removeValue()
        //print(cell.textLabel?.text)
        //tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
}

    func getList()
    {
        refHandle = ref.child("list").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let list = List()
                list.setValuesForKeys(dictionary)
                self.lists.append(list)
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
