//
//  AppDelegate.swift
//  BLE Stoica
//
//  Created by Vlad Stoica on 18/08/15.
//  Copyright © 2015 Vlad Stoica. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    let locationManager = CLLocationManager()
    var lastProximity: CLProximity?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        locationManager.delegate = self;
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
            locationManager.requestAlwaysAuthorization()
        }
        
        let uuid = NSUUID(UUIDString: "A0B13730-3A9A-11E3-AA6E-0800200C9A66")
        let beacon_range = CLBeaconRegion(proximityUUID: uuid!, identifier: "Entrance BLE")
        
        if(!CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion)){
            NSLog("22")
        }
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startMonitoringForRegion(beacon_range)
        locationManager.startRangingBeaconsInRegion(beacon_range)
        locationManager.startUpdatingLocation()
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            application.registerUserNotificationSettings(
                UIUserNotificationSettings(
                    forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Sound],
                    categories: nil
                )
            )
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

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
        if(nearestBeacon.proximity == lastProximity ||
            nearestBeacon.proximity == CLProximity.Unknown){
                return;
        }
        lastProximity = nearestBeacon.proximity;
        sendLocationNotification("Welcome home! Home sweet home!")
    }
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        manager.startUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
        manager.stopUpdatingLocation()
        sendLocationNotification("Good bye! Have a good day")
        
    }
}

