//
//  LocationsViewController.swift
//  Saucepan
//
//  Created by Kaltrina UKA on 4/14/19.
//  Copyright © 2019 Kaltrina UKA. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        getUserCurrentLocation()
        
    }

    func getUserCurrentLocation(){
        
        locationManager.requestWhenInUseAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
            setupLocations()
        }
        
    }

    
    func setupLocations(){
        
        let myLocation = CLLocationCoordinate2D(latitude: (locationManager.location!.coordinate.latitude), longitude: (locationManager.location!.coordinate.longitude))
        let myAnnotation = MKPointAnnotation()
        myAnnotation.title = "Me!"
        myAnnotation.coordinate = myLocation
        mapView.addAnnotation(myAnnotation)
       
        setupRegion(myLocation)
        
        let sonderLocation = CLLocationCoordinate2D(latitude: 42.6550054, longitude: 21.1658997)
        let sonderAnnotation = MKPointAnnotation()
        sonderAnnotation.title = "Sonder"
        sonderAnnotation.coordinate = sonderLocation

        let bukatoreLocation = CLLocationCoordinate2D(latitude: 42.652481, longitude: 21.169505)
        let bukatoreAnnotation = MKPointAnnotation()
        bukatoreAnnotation.title = "Bukatore"
        bukatoreAnnotation.coordinate = bukatoreLocation
        
        let rockuzineLocation = CLLocationCoordinate2D(latitude: 42.661122, longitude: 21.150591)
        let rockuzineAnnotation = MKPointAnnotation()
        rockuzineAnnotation.title = "Rockuzine"
        rockuzineAnnotation.coordinate = rockuzineLocation
        
        let sachLocation = CLLocationCoordinate2D(latitude: 42.641501, longitude: 21.111999)
        let sachAnnotation = MKPointAnnotation()
        sachAnnotation.title = "Sach"
        sachAnnotation.coordinate = sachLocation
        
        drawPath(source: myAnnotation, destination: sonderAnnotation)
        drawPath(source: myAnnotation, destination: bukatoreAnnotation)
        drawPath(source: myAnnotation, destination: rockuzineAnnotation)
        drawPath(source: myAnnotation, destination: sachAnnotation)

    }
    
    func setupRegion(_ location: CLLocationCoordinate2D){
        
        let regionDistance: CLLocationDistance = 6000
        
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.region = coordinateRegion
        
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.randomFlat()
        renderer.lineWidth = 5.0
        return renderer
        
    }
    
    
    func drawPath(source: MKAnnotation, destination: MKAnnotation){
        
        let sourcePlacemark = MKPlacemark(coordinate: source.coordinate, addressDictionary: nil)
        mapView.addAnnotation(source)
        
        let destinationPlacemark = MKPlacemark(coordinate: destination.coordinate, addressDictionary: nil)
        mapView.addAnnotation(destination)

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let directionsRequest = MKDirections.Request()
        
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destinationMapItem
        directionsRequest.transportType = .automobile
        
        let direction = MKDirections(request: directionsRequest)
        
        direction.calculate{
            (response, error) -> Void in
            guard let response = response else {
                if let error = error{
                    print("error = \(String(describing: error))")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
        }
    }

}
