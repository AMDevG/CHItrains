//
//  SavedStopViewController.swift
//  ChiTrain
//
//  Created by John Berry on 3/13/17.
//  Copyright © 2017 dev G Development. All rights reserved.
//

import UIKit

class SavedStopViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var savedStops = [FavoriteStop]()
    var selectedStation = String()
    var selectedID = String()
    var selectedColor = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedStops.count
    }

    func getData(){
        do{
            savedStops = try context.fetch(FavoriteStop.fetchRequest())
        }catch{
            print("Error failed to fetch")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! SavedStopCellClass
        let stop = savedStops[indexPath.row]
        
        if let stopName = stop.stopName{
            cell.nameLabel.text = stopName
        }
        if stop.stopColor == "Red"{
            cell.colorLabel.backgroundColor = UIColor.red}
        else if stop.stopColor == "Green"{
            cell.colorLabel.backgroundColor = UIColor.green}
        else if stop.stopColor == "Pink"{
            cell.colorLabel.backgroundColor = UIColor.magenta}
        else if stop.stopColor == "Blue"{
            cell.colorLabel.backgroundColor = UIColor.blue}
        else if stop.stopColor == "Brown"{
            cell.colorLabel.backgroundColor = UIColor.brown}
        else if stop.stopColor == "Orange"{
            cell.colorLabel.backgroundColor = UIColor.orange}
        else if stop.stopColor == "Purple"{
            cell.colorLabel.backgroundColor = UIColor.purple}
        else if stop.stopColor == "Yellow"{
            cell.colorLabel.backgroundColor = UIColor.yellow}
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as! SavedStopCellClass
        let selectedStop = savedStops[(indexPath?.row)!]
        selectedStation = selectedStop.stopName!
        //selectedID = (selectedStop.stopID?)!
       // selectedColor = selectedStop.stopColor!

        self.performSegue(withIdentifier: "showFaveDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFaveDetail"{
            let newViewController: PredictionViewController = segue.destination as! PredictionViewController
            newViewController.stationID = selectedID
            newViewController.stopString = selectedStation
            newViewController.colorRoute = selectedColor
        }
    }

}
