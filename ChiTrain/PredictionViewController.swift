//
//  PredictionViewController.swift
//  ChiTrain
//
//  Created by John Berry on 2/11/17.
//  Copyright © 2017 dev G Development. All rights reserved.
//

import UIKit

class PredictionViewController: UITableViewController {
    
    var stationID : String!
    
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
    
        guard let requestUrl = URL(string:searchURL) else { return }
        let request = URLRequest(url:requestUrl)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("Returned data:  \(json)")
            }
        }.resume()
    }

}
