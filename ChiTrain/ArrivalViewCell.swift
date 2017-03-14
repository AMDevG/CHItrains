//
//  TableViewCell.swift
//  ChiTrain
//
//  Created by John Berry on 2/26/17.
//  Copyright © 2017 dev G Development. All rights reserved.
//

import UIKit

class ArrivalViewCell: UITableViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var destLabel: UILabel!
    @IBOutlet weak var measurmentLable: UILabel!
    @IBOutlet weak var arrivMins: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    

}
