//
//  StopChoiceViewController.swift
//  ChiTrain
//
//  Created by John Berry on 2/10/17.
//  Copyright © 2017 dev G Development. All rights reserved.
//

import UIKit

class StopChoiceViewController: UITableViewController {

    var lineSelection: String!
    var stopNames = [String: String]()
    var selectedStation: String!
    var sortedNames = [String]()
    
    @IBOutlet weak var stopLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if lineSelection! == "Red"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.redStopIds
            sortedNames = Array(DestViewController.redStopIds.keys).sorted{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        if lineSelection! == "Blue"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.blueStopIds
             sortedNames = Array(DestViewController.blueStopIds.keys).sorted{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        if lineSelection! == "Brown"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.brownStopIds
             sortedNames = Array(DestViewController.brownStopIds.keys).sorted{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        if lineSelection! == "Green"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.greenStopIds
             sortedNames = Array(DestViewController.greenStopIds.keys).sorted{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        if lineSelection! == "Orange"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.orangeStopIds
             sortedNames = Array(DestViewController.orangeStopIds.keys).sorted{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        if lineSelection! == "Purple"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.purpleStopIds
             sortedNames = Array(DestViewController.purpleStopIds.keys).sorted{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        if lineSelection! == "Pink"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.pinkStopIds
             sortedNames = Array(DestViewController.pinkStopIds.keys).sorted{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
        if lineSelection! == "Yellow"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.yellowStopIds
             sortedNames = Array(DestViewController.yellowStopIds.keys).sorted{ $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stopNames.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopCell", for: indexPath)
        //let key = Array(self.stopNames.keys)[indexPath.row]
        let key = sortedNames[indexPath.row]
        cell.textLabel?.text = key
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        selectedStation = currentCell.textLabel!.text!
        
        self.performSegue(withIdentifier: "showStopDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStopDetail"{
            let newViewController: PredictionViewController = segue.destination as! PredictionViewController
            let selectedID = stopNames[selectedStation]
            newViewController.stationID = selectedID
            newViewController.stopString = selectedStation
            newViewController.colorRoute = lineSelection
        }
    }
}
