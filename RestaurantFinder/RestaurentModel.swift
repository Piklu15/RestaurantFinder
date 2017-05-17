//
//  YelpPlacer.swift
//  RestaurantFinder
//
//  Created by Zert Interactive on 5/11/17.
//  Copyright © 2017 Zert Interactive. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
class RestaurentModel{
    var name: String
    var  coordinate: CLLocationCoordinate2D
    var address : String
    var location : [String]
    var rating : Double
    var review : Double
    var imageUrlString : String
    var categories : String
    var phone: String
   
    init(modeldict:[String:Any]) {
        
        coordinate = CLLocationCoordinate2DMake(modeldict["lat"]  as! CLLocationDegrees,modeldict["lng"] as! CLLocationDegrees)
        name = modeldict["name"] as! String
        
        rating = modeldict["rating"] as! Double
        
        address = (modeldict["location"] as! [String]).first!
        location = modeldict["location"] as! [String]
        phone = modeldict["phone"] as! String
        
        imageUrlString = modeldict["url"] as! String
        
        categories = modeldict["category"] as! String
        
        review = modeldict["review"] as! Double
        
      //  print("address is : \(address)lat is : \(coordinate.latitude) and long is : \(coordinate.longitude) and name : \(name)")
    
    
    }
    
}
