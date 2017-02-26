//
//  PredictionViewController.swift
//  ChiTrain
//
//  Created by John Berry on 2/11/17.
//  Copyright © 2017 dev G Development. All rights reserved.
//

import UIKit
import SwiftyJSON


class PredictionViewController: UITableViewController {
    
    var stationID : String!
    var colorRoute: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadPredictions()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func downloadPredictions(){
        
        let baseURL = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=2ef142eb986f42cb9b087645f68e65d2&mapid="
        let JsonOutput = "&max=25&outputType=JSON"
        let searchURL = baseURL + stationID + JsonOutput
        let requestUrl = URL(string:searchURL)
        let jsonData = NSData(contentsOf: requestUrl!)
        let readableJSON = try! JSONSerialization.jsonObject(with: jsonData! as Data, options: []) as! [String:AnyObject]
        let object = JSON(readableJSON)
        let searchCriteria = object["ctatt"]
        let errorCode = searchCriteria["errCd"]
        
        let arrivalTimes = searchCriteria["eta"]
        
        if errorCode > 0{
            print("Error from Prediction system")
        }
        print(arrivalTimes[0])
    }
    
    
    
    
    
}
