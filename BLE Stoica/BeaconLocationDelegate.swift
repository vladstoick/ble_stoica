//
//  BeaconLocationHandler.swift
//  BLE Stoica
//
//  Created by Vlad Stoica on 29/08/15.
//  Copyright © 2015 Vlad Stoica. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class BeaconLocationDelegate: NSObject, CLLocationManagerDelegate {

    let hueService = HueService()
    
    var lastProximity: CLProximity?
    
    func sendLocationNotification (message: String){
        let notification = UILocalNotification()
        notification.alertBody = message
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if(beacons.count == 0){
            return;
        }
        
        let nearestBeacon:CLBeacon = beacons[0]
        
        let proximity = nearestBeacon.proximity
        
        if(proximity == lastProximity){
            return
        }
        
        if(nearestBeacon.proximity == CLProximity.Immediate ||
            nearestBeacon.proximity == CLProximity.Near){
            hueService.turnOnLight(3)
        } else {
            hueService.turnOffLight(3)
        }
        
        lastProximity = nearestBeacon.proximity;
//        sendLocationNotification("Welcome home! Home sweet home!")
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        manager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
        manager.stopUpdatingLocation()
//        sendLocationNotification("Good bye! Have a good day")
        
    }
}