//
//  ViewController.swift
//  BLE Stoica
//
//  Created by Vlad Stoica on 18/08/15.
//  Copyright © 2015 Vlad Stoica. All rights reserved.
//

import UIKit
import CoreLocation

class HueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter
            .defaultCenter()
            .addObserver(
                self,
                selector: "handleHueChanges:",
                name: "hueStateChanged", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSNotificationCenter.defaultCenter().removeObserver(self);
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBAction func didClickTurnOnButton(sender: AnyObject) {
        HueService().turnOnLight(3)
    }

    @IBAction func didClickTurnOffButton(sender: AnyObject) {
        HueService().turnOffLight(3)
    }
    
    func handleHueChanges(notification: NSNotification){
        let object = notification.object as! Dictionary<String, AnyObject>
        let newState = object["state"] as! Bool
//        let lightID = object["lightID"] as! Int
        stateLabel.text = "On: " + String(newState)
        
    }

}

