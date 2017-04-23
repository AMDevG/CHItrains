//
//  PredictionViewController.swift
//  ChiTrain
//
//  Created by John Berry on 2/11/17.
//  Copyright © 2017 dev G Development. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import CoreData
import SystemConfiguration

let baseURL = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=2ef142eb986f42cb9b087645f68e65d2&mapid="
let JsonOutput = "&max=50&outputType=JSON"

let sections = ["Northbound", "Southbound"]

class PredictionViewController: UITableViewController {
    
    class Prediction{
        
        var stpId : String?    //UNIQUE ID; DICTIONARY KEY (EG. ID OF NORTHBOUND TRAIN AT FULLERTON)
        var staId : String?     //UNIQUE ID TO STATION; DOESNT SPECIFY
        var stpDe : String? // "SERVICE AT OUTER LOOP PLATFORM"
        var isSch : String?
        var prdt : String?  //PREDICTED DEPARTURE TIME
        var rt : String?    // COLOR OF TRAIN RUN
        var isApp : String?
        var arrT : String?  //  PREDICTED ARRIVAL TIME
        var isFlt : String?
        var trDr : String?
        var rn : String?
        var staNm : String?
        var destNm : String? // I.E. KIMBALL, 95 DAN RYAN
        var isDly : String?
        var flags : String? // SET TO NULL UNLESS FLAGGED
        var destSt : String?// DESTINATION STATION NUMBER
        var arrivalTime : String?// COMPUTED FUNCTION
    
    }


    var stationID: String!
    var stopString: String!
    var colorRoute: String!
    var returnTime = String()
    var routeFilter = String()
    
    var arrivalTimes: JSON?
    var predictionArray = [JSON]()
    var SouthBoundPreds = [Prediction]()
    var NorthBoundPreds = [Prediction]()
    var AllPredictions = [[Prediction]]()

    var data_available = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let connectionCheck = isConnectedToNetwork()
            
           if colorRoute! == "Red"{
                routeFilter = "Red"}
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
        
        if connectionCheck == false{
            // CHECK FOR NETWORK CONNECTIVITY
            // SEND BACK TO ROOT VIEW CONTROLLER IF NOT NO NETWORK CONNECTION AVAILABLE
            
            _ = navigationController?.popToRootViewController(animated: true)
            let connectionAlert = UIAlertController(title: "No Network", message: "Check your network connection and try again", preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "OK!", style: .default, handler: nil)
            connectionAlert.addAction(acceptAction)
            present(connectionAlert, animated: true, completion: nil)
        }
        else{
            downloadPredictions()
            clearPredictionObjects()
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        for array in AllPredictions{
            for prediction in array{
                prediction.stpId = nil
                prediction.staId = nil
                prediction.stpDe = nil
                prediction.isSch = nil
                prediction.prdt = nil
                prediction.rt = nil
                prediction.isApp = nil
                prediction.arrT = nil
                prediction.isFlt = nil
                prediction.trDr = nil
                prediction.rn = nil
                prediction.staNm  = nil
                prediction.destNm = nil
                prediction.isDly = nil
                prediction.flags = nil
                prediction.destSt = nil
                prediction.arrivalTime = nil
            }
        }
    }
    
    func downloadPredictions(){
        
        //CHECK FOR INTERNET CONNECTION
            let download_thread = DispatchQueue.global(qos: .background)
            download_thread.async {
                
                let searchURL = baseURL + self.stationID + JsonOutput
                guard let requestUrl = URL(string:searchURL)
                    else{return}
                let jsonData = NSData(contentsOf: requestUrl)
                let readableJSON = try! JSONSerialization.jsonObject(with: jsonData! as Data, options: []) as! [String:AnyObject]
                let object = JSON(readableJSON)
                let searchCriteria = object["ctatt"]
                let arrivalTimes = searchCriteria["eta"]
            //PASSES DICTIONARY WITH KEY "ETA" TO PARSE FUNCTION; DATA TYPE BEING PASSED IS JSON
           
                let parse_thread = DispatchQueue.global(qos: .background)
                    parse_thread.async{
                        self.parseJSon(arrivalTimes)
                    }
            }
    }
    
    func parseJSon(_ jsonArray: JSON){
        let counter = jsonArray.count
        for index in 0 ... counter{
            var prediction = jsonArray[index]
            if prediction["rt"].string == routeFilter{
                predictionArray.append(prediction)
            }
        }
        
        for pred in predictionArray{
            
            let prediction = Prediction()
                //CREATES PREDICTION OBJECTS AND APPENDS THEM TO ARRAY BASED ON DIRECTION (NORTH/SOUTH)
                //NORTH/SOUTH ARRAYS ARE THEN APPENDED TO A MASTER ARRAY WITH ALL PREDICTIONS (BOTH NORTH AND SOUTH)
                //DATA AVAILABLE IS FLIPPED TRUE
        
                prediction.stpId = pred["stpId"].string!
                prediction.staId = pred["staId"].string!
                prediction.stpDe = pred["stpDe"].string!
                prediction.isSch = pred["isSch"].string!
                prediction.prdt = pred["prdt"].string!
                prediction.rt = pred["rt"].string!
                prediction.isApp = pred["isApp"].string!
           
                prediction.arrT = pred["arrT"].string!
                prediction.isFlt = pred["isFlt"].string!
                prediction.trDr = pred["trDr"].string!
                prediction.rn = pred["rn"].string!
                prediction.staNm = pred["staNm"].string!
                prediction.destNm = pred["destNm"].string!
            
            switch prediction.destNm!{
                case "95th/Dan Ryan":
                    SouthBoundPreds.append(prediction)
                case "Forest Park":
                    SouthBoundPreds.append(prediction)
                case "Loop":
                    SouthBoundPreds.append(prediction)
                case "Skokie":
                    SouthBoundPreds.append(prediction)
                case "Harlem/Lake":
                    SouthBoundPreds.append(prediction)
                case "Linden":
                    SouthBoundPreds.append(prediction)
                case "Howard":
                    NorthBoundPreds.append(prediction)
                case "O'Hare":
                    NorthBoundPreds.append(prediction)
                case "Kimball":
                    NorthBoundPreds.append(prediction)
                case "54th/Cermak":
                    NorthBoundPreds.append(prediction)
                case "Midway":
                    NorthBoundPreds.append(prediction)
                case "Ashland/63rd":
                    NorthBoundPreds.append(prediction)
                case "Cottage Grove":
                    NorthBoundPreds.append(prediction)
                case "63rd Street":
                    NorthBoundPreds.append(prediction)
            default:
                print("Destination not found")
            }
        }
        
        AllPredictions.append(NorthBoundPreds)
        AllPredictions.append(SouthBoundPreds)
        
        let arrival_timequeue = DispatchQueue.global(qos: .background)
        
        //Arrival time queue calculates arrival times async and updates main thread
        //AFTER ALL PREDICTION OBJECTS HAVE BEEN UPDATED
        
        arrival_timequeue.async{
            for predSet in self.AllPredictions{
                for predict in predSet{
                    predict.arrivalTime = self.calculate_arrival_time(predict.arrT!)
                    
                }
            }
            DispatchQueue.main.async{
                self.data_available = true
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      if(data_available){
            let cell = tableView.dequeueReusableCell(withIdentifier: "predictionCell", for: indexPath) as! ArrivalViewCell
            let currentPrediction = AllPredictions[indexPath.section][indexPath.row]
            cell.arrivMins.text = currentPrediction.arrivalTime
            cell.destLabel.text = currentPrediction.destNm
                if colorRoute! == "Red"{
                    cell.colorLabel.backgroundColor = UIColor.red}
                else if colorRoute! == "Green"{
                    cell.colorLabel.backgroundColor = UIColor.green}
                else if colorRoute! == "Pink"{
                    cell.colorLabel.backgroundColor = UIColor.magenta}
                else if colorRoute! == "Blue"{
                    cell.colorLabel.backgroundColor = UIColor.blue}
                else if colorRoute! == "Brown"{
                    cell.colorLabel.backgroundColor = UIColor.brown}
                else if colorRoute! == "Orange"{
                    cell.colorLabel.backgroundColor = UIColor.orange}
                else if colorRoute! == "Purple"{
                    cell.colorLabel.backgroundColor = UIColor.purple}
                else if colorRoute! == "Yellow"{
                    cell.colorLabel.backgroundColor = UIColor.yellow}
        return cell
    }
      
      else{
            let defaultCell = tableView.dequeueReusableCell(withIdentifier: "PlaceholderCell", for: indexPath)
        return defaultCell
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data_available ? AllPredictions[section].count: 15
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sections.count {
            return sections[section]
        }
        return nil
    }
    
    func clearPredictionObjects(){
        for array in AllPredictions{
            for prediction in array{
                prediction.stpId = nil
                prediction.staId = nil
                prediction.stpDe = nil
                prediction.isSch = nil
                prediction.prdt = nil
                prediction.rt = nil
                prediction.isApp = nil
                prediction.arrT = nil
                prediction.isFlt = nil
                prediction.trDr = nil
                prediction.rn = nil
                prediction.staNm  = nil
                prediction.destNm = nil
                prediction.isDly = nil
                prediction.flags = nil
                prediction.destSt = nil
                prediction.arrivalTime = nil
            }
        }
    }
    
    @IBAction func addPush(_ sender: Any) {
        
        /// ADDS CURRENT STOP TO FAVORITES LIST
        /// FIELDS IN CONTEXT ARE NAME COLOR & ID
        /// ERROR GUARD IN DO CATCH
        /// ALERTS AFTER SUCCESSFUL SAVE
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let favorite = FavoriteStop(context: context)
        favorite.stopName = stopString
        favorite.stopColor = colorRoute
        favorite.stopID = stationID
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {try context.save()}
        catch {fatalError("Failure to save context: \(error)")}
        
        let alertController = UIAlertController(title: "Saved Stops", message: "Added to Favorites!", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(acceptAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func calculate_arrival_time(_ timestamp: String)-> String{
        let preFormattedkey = timestamp
        let key = preFormattedkey.replacingOccurrences(of: "T", with: "-")
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "CST") as TimeZone!
        
        let now = dateFormatter.string(from: date)
        let currTime = dateFormatter.date(from: now)
        //Gets current local time formats and turns back into date object for subtraction
        
        let predTime = dateFormatter.date(from: key)
        let waitTime = predTime?.timeIntervalSince(currTime!)
        var doubWaitTime = Double(waitTime!)
        doubWaitTime = round(doubWaitTime/60.0)
        let intWaitTime = Int(doubWaitTime)
        
        if intWaitTime == 0 || intWaitTime < 0{
            returnTime = "Due"
        }
        else{
            returnTime = String(intWaitTime)
        }
        return returnTime
    }
    
    
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
    
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}




