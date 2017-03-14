//
//  PredictionViewController.swift
//  ChiTrain
//
//  Created by John Berry on 2/11/17.
//  Copyright © 2017 dev G Development. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class PredictionViewController: UITableViewController {

    
    
    var stationID : String!
    var colorRoute: String!
    var routeFilter = String()
    var SouthBoundPreds = [JSON]()
    var NorthBoundPreds = [JSON]()
    var predictionArray = [JSON]()
    
 
    @IBAction func addPush(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let favorite = FavoriteStop(context: context)
        
        favorite.stopName = stationID
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            try context.save()
            print("Saved Context")
            
            
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "FavoriteStop", in: context)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let result = try context.fetch(fetchRequest)
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }

    }
    
    var AllPredictions = [[JSON]]()
    
    let sections = ["Northbound", "Southbound"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                case "95th/Dan Ryan":
                    SouthBoundPreds.append(pred)
                case "Forest Park":
                    SouthBoundPreds.append(pred)
                case "Loop":
                    SouthBoundPreds.append(pred)
                case "Skokie":
                    SouthBoundPreds.append(pred)
                case "Harlem/Lake":
                    SouthBoundPreds.append(pred)
                case "Linden":
                    SouthBoundPreds.append(pred)
                case "Howard":
                    NorthBoundPreds.append(pred)
                case "O'Hare":
                    NorthBoundPreds.append(pred)
                case "Kimball":
                    NorthBoundPreds.append(pred)
                case "54th/Cermak":
                    NorthBoundPreds.append(pred)
                case "Midway":
                    NorthBoundPreds.append(pred)
                case "Ashland/63rd":
                    NorthBoundPreds.append(pred)
                case "Cottage Grove":
                    NorthBoundPreds.append(pred)
                case "63rd Street":
                    NorthBoundPreds.append(pred)
            default:
                print("Error")
            }
            
        }
        AllPredictions.append(NorthBoundPreds)
        AllPredictions.append(SouthBoundPreds)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "predictionCell", for: indexPath) as! ArrivalViewCell
        var currentDict = AllPredictions[indexPath.section][indexPath.row]
        var arriveTime = currentDict["arrT"].string
        arriveTime = calculate_arrival_time(arriveTime!)
        let destinationLabel = currentDict["destNm"].string
        
        cell.arrivMins.text = arriveTime
        cell.destLabel.text = destinationLabel
        
        
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllPredictions[section].count
        print("number of rows is  \(AllPredictions[section].count)")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
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
        var intWaitTime = Int(waitTime!)
        intWaitTime = intWaitTime/60
        let returnTime = String(intWaitTime)
        return returnTime
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
    
    
    
}




