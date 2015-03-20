//
//  BDBNavigationController.swift
//  BigDataBuses
//
//  Created by Ayush Mehra on 3/16/15.
//  Copyright (c) 2015 amehra. All rights reserved.
//

import Foundation
import UIKit

class BDBNavigationController: ENSideMenuNavigationController, ENSideMenuDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu = ENSideMenu(sourceView: self.view, menuTableViewController: SideMenuTableViewController(), menuPosition:.Left)
        //sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 180.0 // optional, default is 160
        sideMenu?.bouncingEnabled = false
        
        view.bringSubviewToFront(navigationBar)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sideMenuWillOpen() {
        println("side menu will open")
    }
    
    func sideMenuWillClose() {
        println("side menu will close")
    }
    
}


