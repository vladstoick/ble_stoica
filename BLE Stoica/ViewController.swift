//
//  ViewController.swift
//  BLE Stoica
//
//  Created by Vlad Stoica on 18/08/15.
//  Copyright © 2015 Vlad Stoica. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didClickTurnOnButton(sender: AnyObject) {
        HueService().turnOnLight(3)
    }

    @IBAction func didClickTurnOffButton(sender: AnyObject) {
        HueService().turnOffLight(3)
    }

}

