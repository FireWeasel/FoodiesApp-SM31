//
//  Fruits.swift
//  Foodies
//
//  Created by Fhict on 29/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit

class Fruit:NSObject {
    var name:String?
    var imageItem:String?
    
    override init() {}
}
class Vegetable:NSObject {
    var name:String?
    var imageItem:String?
    
    override init() {}
}
class Meat:NSObject {
    var name:String?
    var imageItem:String?
    //var price:Any?
    
    override init(){}
}
class Other:NSObject{
    var name:String?
    var imageItem:String?
    
    override init() {}
}
class Recipe:NSObject{
    var tips: String?
    var favorite: String?
    var ingredient :String?
    var name: String?
    var timeToPrepare:String?
    var imageItem:String?
    
    override init() {}
}

class List:NSObject{
    var name:String?
    var quantity:String?
    var imageItem:String?
    
    override init() {}
}

