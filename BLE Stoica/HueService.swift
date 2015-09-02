//
//  HueService.swift
//  BLE Stoica
//
//  Created by Vlad Stoica on 29/08/15.
//  Copyright © 2015 Vlad Stoica. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol HueServiceDelegate{
    
}

class HueService {
    
    let user = "82c96b92b795c376aca0fd13694d3b"
    let ip = "http://192.168.0.2/api/"
    
    
    func turnOnLight(lightID:Int){
        toggleStateForLight(lightID, state: true)
    }
    
    func turnOffLight(lightID:Int){
        toggleStateForLight(lightID, state: false)
    }
    
    private func toggleStateForLight(lightID:Int, state:Bool){
        let url = ip + user + "/lights/" + String(lightID)
        Alamofire.request(Method.GET, url).responseJSON { _, _, result in
            let json = JSON(result.value!)
            let oldState = json["state"]["on"].bool
            if (oldState != state){
                self.toggleStateForLightRequest(lightID, state: state)
            }
        }
    }
    
    private func toggleStateForLightRequest(lightID:Int, state:Bool){
        let url = ip + user + "/lights/" + String(lightID) + "/state"
        let params = ["on":state]
        Alamofire.request(Method.PUT, url,parameters: params, encoding: .JSON)
            .responseJSON { _, _, result in
                let obj = [ "state": state, "lightId": lightID ]
                let notification = NSNotification(name: "hueStateChanged", object: obj)
                NSNotificationCenter
                    .defaultCenter()
                    .postNotification(notification)
            }

    }
}