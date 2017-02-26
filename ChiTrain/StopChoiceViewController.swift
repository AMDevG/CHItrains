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
    @IBOutlet weak var stopLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if lineSelection! == "Red"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.redStopIds
        }
        if lineSelection! == "Blue"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.blueStopIds
        }
        if lineSelection! == "Brown"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.brownStopIds
        }
        if lineSelection! == "Green"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.greenStopIds
        }
        if lineSelection! == "Orange"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.orangeStopIds
        }
        if lineSelection! == "Purple"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.purpleStopIds
        }
        if lineSelection! == "Pink"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.pinkStopIds
        }
        if lineSelection! == "Yellow"{
            let DestViewController: StopDictionaryViewController = StopDictionaryViewController()
            stopNames = DestViewController.yellowStopIds
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
        var key = Array(self.stopNames.keys)[indexPath.row]
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
            var selectedID = stopNames[selectedStation]
            newViewController.stationID = selectedID
            newViewController.colorRoute = lineSelection
            
        }
    }
}
