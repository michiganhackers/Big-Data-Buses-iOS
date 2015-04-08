//
//  BusData.swift
//  BigDataBuses
//
//  Created by Ayush Mehra on 4/2/15.
//  Copyright (c) 2015 amehra. All rights reserved.
//

import Foundation
import MapKit

struct Route {
    let id: Int
    let name: String
    let shortName: String
    let path: MKPolyline
    let stopIDs: [Int]
    
    init(jsonData: NSDictionary) {
        
        id = jsonData["id"] as Int
        name = jsonData["name"] as String
        shortName = jsonData["short_name"] as String
        stopIDs = jsonData["stops"] as [Int]
        
        let points = jsonData["path"] as [Double]
        
        var mapPoints = [CLLocationCoordinate2D]()
        
        for i in 0..<points.count/2 {
            let lat = points[2*i]
            let long = points[2*i+1]
            
            mapPoints.append(CLLocationCoordinate2D(latitude: lat, longitude: long))
        }
        
        path = MKPolyline(coordinates: &mapPoints, count: mapPoints.count)
    }
    
}

class BusData {
    
    var routes = [Route]();
    var routesData = NSData();
    
    func test(){
        println("hello");
    }
    
    func getRoutes(completionBlock: () -> Void) {
        /*
        routesData = NSData(contentsOfURL: NSURL(string: "http://iub.doublemap.com/map/v2/routes")!)!;
        
        var asdf = NSData(contentsOfURL: NSURL(string:"http://iub.doublemap.com/map/v2/routes"), options: NSDataBase64DecodingOptions(), error: NSErrorPointer());
        */
        let url = NSURL(string: "http://mbus.doublemap.com/map/v2/routes")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            let objects = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as [NSDictionary]
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.routes = objects.map { Route(jsonData: $0) }
                completionBlock()
            }
            
            //self.routesData = NSData(base64EncodedData: data, options: NSDataBase64DecodingOptions())!
        }
        
        task.resume()

    }
    
    func getRoutesData()->NSData{
        println(routesData);
        return routesData;
    }
}
