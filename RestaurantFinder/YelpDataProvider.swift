
//
//  YelpDataProvider.swift
//  RestaurantFinder
//
//  Created by Zert Interactive on 5/11/17.
//  Copyright © 2017 Zert Interactive. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class YelpDataProvider{

    
func fetchPlacesNearCoordinate(_ coordinate: CLLocationCoordinate2D, radius: Double, completion: @escaping (([RestaurentModel]) -> Void)) -> (){
    
    
        var arrayOfYelpPlacer = [RestaurentModel]()
        let lat = coordinate.latitude as Double
        let long = coordinate.longitude as Double
        
        var r  = URLRequest(url: URL(string: "https://api.yelp.com/v3/businesses/search?term=restaurant&latitude=\(lat)&longitude=\(long)&limit=10"
            )!)
        r.httpMethod = "GET"
        r.setValue("Bearer 99VFEOxyNYyeXWHkcRGaTCFEvXh-p_sJaed-aRW5n-U4uvl7Sv9ujHY-jz_sruq9q63foEpGyyMYMrgddDaYcpJQemJ1w6T6bh_i6lX4Mg-sjvxpTFYLK3u_7XQRWXYx", forHTTPHeaderField: "Authorization")
        r.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let task = URLSession.shared.dataTask(with: r) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                
                guard  let arrayofDictionary = responseJSON["businesses"] as? [[String:Any]] else{
                    return
                }
                
                for dict in arrayofDictionary{
                    
                    
                    guard let coordin = dict["coordinates"] as? [String:Any],
                        let lat = coordin["latitude"] as? Double, let lng = coordin["longitude"] as? Double else{
                            
                            return
                    }
                    
                    guard let  name = dict["name"] as? String else{
                      return
                    }
                    
                    guard let rating = dict["rating"] as? Double else{
                        return
                    }
                    
                    guard let review = dict["review_count"] as? Double else{
                        return
                    }
                    
                    guard let displayPhone = dict["display_phone"] as? String else{
                        return
                    }
                    
                    guard let location = dict["location"] as? [String:Any] ,
                        let displayAddress = location["display_address"] as? [String] else{
                            
                            print("location not found ")
                            return
                    }
                    
                    guard let categor = dict["categories"] as? [[String:Any]] else{
                    
                        return
                    }
                    
                     var categoryString = ""
                    for  dict in categor{
                    
                        
                        if let title = dict["title"] as? String{
                        
                            categoryString += "\(title),"
                            
                            
                        }
                        
                    }
                    
                    let categories = categoryString.substring(to: categoryString.index(before: categoryString.endIndex))
                   
                    guard let imageUrl = dict["image_url"] as? String else{
                    
                        return
                    }
                    
                    
                    let modelDictionary:[String:Any] = ["lat":lat,"lng":lng,"name":name,"location":displayAddress,"rating":rating,"url":imageUrl,"category":categories,"review":review,"phone":displayPhone]
                    
                    arrayOfYelpPlacer.append(RestaurentModel(modeldict: modelDictionary))

                    
                   // print(lat)
                }
                
                
                completion(arrayOfYelpPlacer)
                
                
            }
            else {
                
                print(error?.localizedDescription ?? "No")
            }
        }
        task.resume()
        
        
        
        
    }
    
    
}
