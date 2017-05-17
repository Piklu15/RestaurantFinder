//
//  Marker.swift
//  RestaurantFinder
//
//  Created by Zert Interactive on 5/11/17.
//  Copyright © 2017 Zert Interactive. All rights reserved.
//

import UIKit
import  GoogleMaps
class Marker: GMSMarker {
    var place: RestaurentModel
    
    init(place: RestaurentModel) {
        
        
      
        self.place = place
        super.init()
        title = place.name
        position = place.coordinate
       // icon = UIImage(named: "pin.jpg")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
        
        
    }

}
