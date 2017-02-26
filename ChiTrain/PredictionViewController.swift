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
    
    var SouthBoundPreds = [JSON]()
    var NorthBoundPreds = [JSON]()
    
    var routeFilter = String()

    var predictionArray = [JSON]()
    
    

    
    // JSON VARIABLES
    
    var stpID = String ()
    var staID = String ()
    var stpDe = String ()
    var isSch = String ()
    var prdT = String ()
    var rt = String ()
    var isApp = String ()
    var lat = String ()
    var arrT = String ()
    var heading = String ()
    var isFlt = String ()
    var tnDr = String ()
    var rn = String ()
    var lon = String ()
    var staNm = String ()
    var destNm = String ()
    var isDly = String ()
    var flags = String ()
    var destSt = String ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if colorRoute! == "Red"{
            routeFilter = "Rd"}
        else if colorRoute! == "Green"{
            routeFilter = "G"}
        else if colorRoute! == "Pink"{
            routeFilter = "Pink"}
        else if colorRoute! == "Blue"{
            routeFilter = "Blue"}
        else if colorRoute! == "Brown"{
            routeFilter = "Brn"}
        else if colorRoute! == "Orange"{
            routeFilter = "Org"}
        else if colorRoute! == "Purple"{
            routeFilter = "P"}
        else if colorRoute! == "Yellow"{
            routeFilter = "Y"}
        
        print("Route Filter is  \(routeFilter)")
        downloadPredictions()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func downloadPredictions(){
        
        let baseURL = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=2ef142eb986f42cb9b087645f68e65d2&mapid="
        let JsonOutput = "&max=50&outputType=JSON"
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
       // print(arrivalTimes[0])
        
        //print(arrivalTimes)
        
        parseJSon(arrivalTimes)
    }
    

    func parseJSon(_ jsonArray: JSON){
        
        var counter = jsonArray.count
        
        for index in 0 ... counter{
            
            var prediction = jsonArray[index]
            
            if prediction["rt"].string == routeFilter{
            
                predictionArray.append(prediction)
            }
        }
        
        for pred in predictionArray{
            
            switch pred["destNm"]{
                
                case "Midway":
                
                    NorthBoundPreds.append(pred)
            default:
                print("No North Bound")
                
            }
            
            
        }
        
        print("\(NorthBoundPreds)")
        
        
    }
    
    
}

