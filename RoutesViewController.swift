//
//  RoutesViewController.swift
//  BigDataBuses
//
//  Created by Ayush Mehra on 4/9/15.
//  Copyright (c) 2015 amehra. All rights reserved.
//

import UIKit

protocol RoutesViewControllerDelegate: class {
    func routesViewControllerDidFinish(routesViewController: RoutesViewController)
}

class RoutesViewController: UITableViewController {
    
    var routes: [Route] = []
    var selectedRouteIDs = NSMutableSet()
    var delegate: RoutesViewControllerDelegate?
    
    @IBAction func doneButtonAction() {
        delegate?.routesViewControllerDidFinish(self)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    func configureCell(cell: UITableViewCell, forRoute route: Route) {
        cell.textLabel?.text = route.name
        cell.accessoryType = (selectedRouteIDs.containsObject(route.id)) ? .Checkmark : .None
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RouteCell", forIndexPath: indexPath) as UITableViewCell
        
        let route = routes[indexPath.row]
        configureCell(cell, forRoute: route)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let route = routes[indexPath.row]
        
        if selectedRouteIDs.containsObject(route.id) {
            selectedRouteIDs.removeObject(route.id)
        } else {
            selectedRouteIDs.addObject(route.id)
        }
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            configureCell(cell, forRoute: route)
        }
        
    }
    
}
