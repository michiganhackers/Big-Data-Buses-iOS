//
//  ViewController.swift
//  BigDataBuses
//
//  Created by Ayush Mehra on 3/12/15.
//  Copyright (c) 2015 amehra. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    
    var routeRenderers = [MKPolyline: MKPolylineRenderer]()
    
    let locationManager = CLLocationManager()
    let span = MKCoordinateSpanMake(0.05, 0.05)
    let busData = BusData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let location = CLLocationCoordinate2D(
            latitude: 51.50007773,
            longitude: -0.1246402
        )
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Big Ben"
        annotation.subtitle = "London"
        
        mapView.addAnnotation(annotation)
        
        busData.getRoutes {
            
            for route in self.busData.routes {
                self.mapView.addOverlay(route.path)
                
                let renderer = MKPolylineRenderer(polyline: route.path)
                renderer.strokeColor = UIColor.blueColor()
                
                self.routeRenderers[route.path] = renderer
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        println("locations = \(locValue.latitude) \(locValue.longitude)")
        mapView.setRegion(MKCoordinateRegion(center: locValue, span: span),animated: true)
        
        locationManager.stopUpdatingLocation() //UPDATE THIS; ONLY UPDATES LOCATION ONCE
        
    }
    
    @IBAction func menuButtonPressed(sender: AnyObject) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        return routeRenderers[overlay as MKPolyline]
    }
}

