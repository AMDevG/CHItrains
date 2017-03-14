//
//  ViewController.swift
//  ChiTrain
//
//  Created by John Berry on 2/2/17.
//  Copyright © 2017 dev G Development. All rights reserved.
//

import UIKit

class LineViewController: UITableViewController {
    var selectedColor: String!
    let categories = ["Red","Brown", "Purple", "Orange", "Blue", "Green", "Pink", "Yellow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        cell.textLabel?.text =  "\(categories[indexPath.row])"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        selectedColor = currentCell.textLabel!.text!
        self.performSegue(withIdentifier: "showStops", sender: self)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStops"{
            let DestViewController: StopChoiceViewController = segue.destination as! StopChoiceViewController
            DestViewController.lineSelection = selectedColor
            }
        }
    }

    


