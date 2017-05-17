//
//  ViewController.swift
//  RestaurantFinder
//
//  Created by Zert Interactive on 5/12/17.
//  Copyright © 2017 Zert Interactive. All rights reserved.
//

import UIKit
import GoogleMaps


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    var dataProvider = YelpDataProvider()
    var locationManager = CLLocationManager()
    var searchRadius = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        mapView.delegate = self
        
        
        //
        //        let camera = GMSCameraPosition.camera(withLatitude: 37.7848679, longitude: -122.4040062, zoom: 6.0)
        //          mapVIew.camera = camera
        //
        //
        //        let marker = GMSMarker()
        //        marker.position = CLLocationCoordinate2D(latitude: 37.7848679, longitude: -122.4040062)
        //        marker.title = "Sydney"
        //        marker.snippet = "Australia"
        //        marker.map = mapVIew
        
        
        fetchNearbyPlaces(CLLocationCoordinate2D(latitude: 37.786882, longitude: -122.399972))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
        
    }
    
    func fetchNearbyPlaces(_ coordinate: CLLocationCoordinate2D) {
        //   self.mapVIew.clear()
        dataProvider.fetchPlacesNearCoordinate(coordinate, radius:Double(searchRadius)) { [weak self]places in
            for place in places {
                
                DispatchQueue.main.async {
                    
                    let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 15.0)
                    
                    self?.mapView.camera = camera
                    let marker = Marker(place: place)
                    marker.map = self?.mapView
                }
                
                
            }
            
            
        }
    }
    
    
}

extension MapViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
            fetchNearbyPlaces(location.coordinate)
        }
    }
    
    
}


extension MapViewController : GMSMapViewDelegate{
    
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let placeMarker = marker as! Marker
        
        if let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView {
            infoView.name.text = placeMarker.place.name
            infoView.address.text = placeMarker.place.address
            infoView.rating.text = "Rating : \(placeMarker.place.rating)"
            
            
            return infoView
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker){
        
        let placeMarker = marker as! Marker
        
            
    
        let viewModel = RestaurantViewModel(model: placeMarker.place)
        
        let detaiViewController = self.storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController
        
        detaiViewController?.viewModel = viewModel

        
        self.navigationController?.pushViewController(detaiViewController!, animated: true)
        
       // print("Info Window is tapped")
        
    }
    
}

