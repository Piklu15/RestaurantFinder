//
//  ViewModel.swift
//  RestaurantFinder
//
//  Created by Zert Interactive on 5/13/17.
//  Copyright © 2017 Zert Interactive. All rights reserved.
//

import Foundation
import UIKit
class RestaurantViewModel{

    
    var restaurantDetailModel : RestaurentModel

    var name : String
    var categories : String
    var rating : Double
    var reviews : Double
    var location : [String]
    var phone : String
    
    
    
    
    var formattedUrl : URL?{
    
        if let url = URL(string: restaurantDetailModel.imageUrlString){
            return url
        }else{
            
            return nil
        }
    }
    
    
    var formattedReview : String {
    
        
        return "\(reviews) Reviews"
    }
    
    var locatinString : String {
    
        var locStr = ""
        
        for temp in location{
        
            locStr += "\(temp),"
        }
        
        let locationString = locStr.substring(to: locStr.index(before: locStr.endIndex))

        return locationString
        
        
    }
    
    init(model:RestaurentModel) {
    
    restaurantDetailModel = model
    name = model.name
    categories = model.categories
    rating = model.rating
    reviews = model.review
    location = model.location
    phone = model.phone
    
        
    
        
    }
    
    func downloadImageWith(Completion:@escaping (UIImage)->Void){
    
        
        URLSession.shared.dataTask(with: formattedUrl!) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
                Completion(image)
            
            
            }.resume()

        
    }
    
    
}
