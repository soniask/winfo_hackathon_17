//
//  ViewController.swift
//  OneNapAway
//
//  Created by Varun Kumar Viswanth on 1/28/17.
//  Copyright © 2017 Varun Kumar Viswanth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set up location manager
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Sets up Map
        let initialLocation = MKUserLocation()
        
//        let latitude: CLLocationDegrees = 27.175244
//        let longitude: CLLocationDegrees = 8.0399773
        let latitudeDelta: CLLocationDegrees = 0.05
        let longitudeDelta: CLLocationDegrees = 0.05
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        //let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let location = initialLocation.coordinate
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        // Creates annotoation on location
        let annotation = MKPointAnnotation()
        annotation.title = "Your Location"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        // Creates annotation when long press is registered
        let UILPGR = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        UILPGR.minimumPressDuration = 2
        mapView.addGestureRecognizer(UILPGR)
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = (locations[0])
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let latitudeDelta: CLLocationDegrees = 0.05
        let longitudeDelta: CLLocationDegrees = 0.05
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        
        // Creates annotoation on location
        let annotation = MKPointAnnotation()
        annotation.title = "Your Location"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)
        
    }
    
    func longpress(gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: self.mapView)
        let aCoordinate = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        let anAnnotation =  MKPointAnnotation()
        anAnnotation.coordinate = aCoordinate
        anAnnotation.title = "Destination"
        mapView.addAnnotation(anAnnotation)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

