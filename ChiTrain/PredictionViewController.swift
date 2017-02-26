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
        
        print("Calling downloadPredictions")
        
        //var results = [Dictionary]()
        
        let baseURL = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=2ef142eb986f42cb9b087645f68e65d2&mapid="
        let JsonOutput = "&max=25&outputType=JSON"
        
        let searchURL = baseURL + stationID + JsonOutput
        
        
    
        let requestUrl = URL(string:searchURL)
        
        let request = URLRequest(url:requestUrl!)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, AnyObject>
               // let arrivalTimeArray = self.parseReturnedJSON(json as! [])
                print("Back in download func")
                
                var newFeed = json["ctatt"] as! Dictionary<String, AnyObject>
                var predictions = newFeed["eta"]
                
                print(predictions)
                
            }
        
        
    }.resume()

    }
    
    func parseReturnedJSON(_ retjson:[AnyObject]) -> Array<String>{
        
        var newArray = [String]()
        
        print("in Parser")
        
        for item in retjson{
            
            let str_arr = item as! String
            
            newArray.append(str_arr)
            
        }
        
        return newArray
    }
    
   

}
