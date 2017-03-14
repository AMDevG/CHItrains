//
//  StopDictionaryViewController.swift
//  ChiTrain
//
//  Created by John Berry on 2/10/17.
//  Copyright © 2017 dev G Development. All rights reserved.
//

import UIKit

class StopDictionaryViewController: UIViewController {
    
let redStopIds = ["Howard":"40900", "Jarvis":"41190", "Morse":"40100", "Loyola":"41300", "Granville":"40760", "Thorndale":"40880","Bryn Mawr":"41380", "Berwyn":"40340", "Argyle":"41200",
"Lawrence":"40770","Wilson":"40540","Sheridan":"40080","Addison":"41240","Belmont":"41320","Fullerton":"41220","North & Clybourn":"40650", "Clark & Division":"40630","Chicago":"41450","Grand":"40330", "Lake":"40260", "Monroe":"41090","Jackson":"40560","Harrison":"41490","Roosevelt":"41400", "Cermak-Chinatown":"41000","Sox-35th":"40190", "47th":"41230", "Garfield":"41170", "63rd":"40910", "69th":"40990", "79th":"40240", "87th":"41430","95th/Dan Ryan":"40450"]
    
    
let blueStopIds = ["O'Hare":"40890", "Rosemont":"40820", "Cumberland":"40230", "Harlem (Blue - O'Hare Branch)":"40750", "Jefferson Park":"41280","Montrose":"41330", "Irving Park":"40550", "Addison":"41240", "Belmont":"40060", "Logan Square":"41020", "California":"40570","Western (Blue - O'Hare Branch)":"40670", "Damen":"40590", "Division":"40320" ,"Chicago":"41410" ,"Grand":"40490","Clark/Lake":"40380", "Washington":"40370",
    "Monroe":"40790", "Jackson":"40070", "LaSalle":"41340", "Clinton":"40430", "UIC-Halsted":"40350", "Racine":"40470","Illinois Medical District":"40810", "Western (Blue - Forest Park Branch)":"40220", "Kedzie-Homan":"40250","Pulaski":"40920","Cicero":"40970","Austin":"40010", "Oak Park":"40180", "Harlem (Blue - Forest Park Branch)":"40980", "Forest Park":"40390"]
    
let brownStopIds = ["Kimball":"41290", "Kedzie":"41180","Francisco":"40870","Rockwell":"41010", "Western":"41480", "Damen":"40090", "Montrose":"41500" ,"Irving Park":"41460","Addison":"41440", "Paulina":"41310", "Southport":"40360", "Belmont":"41320", "Wellington":"41210", "Diversey":"40530",
    "Fullerton":"41220", "Armitage":"40660","Sedgwick":"40800", "Chicago":"40710", "Merchandise Mart":"40460", "Washington/Wells":"40730", "Quincy":"40040","LaSalle/Van Buren":"40160","Adams/Wabash":"40680", "Randolph/Wabash":"40200", "State/Lake":"40260", "Clark/Lake":"40380"]
    
let greenStopIds = ["Harlem/Lake":"40020", "Oak Park":"41350" ," Ridgeland":"40610" ,"Austin":"41260" , "Central":"40280", "Laramie":"40700", "Cicero":"40480", "Pulaski":"40030","Conservatory-Central Park Drive":"41670", "Kedzie":"41070", "California":"41360", "Ashland":"40170","Morgan":"41510", "Clinton":"41160","Clark/Lake":"40380", "State/Lake":"40260", "Randolph/Wabash":"40200","Adams/Wabash":"40680","Roosevelt":"41400","Cermack-McCormick Place":"41690", "35th-Bronzeville-IIT":"41120", "Indiana":"40300","43rd":"41270", "47th":"41080", "51st":"40130", "Garfield":"40510", "King Drive":"41140", "Cottage Grove":"40720","Halsted":"40940","Ashland/63rd":"40290"]
    
let orangeStopIds = ["Midway":"40930", "Pulaski":"40960", "Kedzie":"41070","Western":"40310", "35th/Archer":"40120", "Ashland":"41060" ,"Halsted":"41130","Roosevelt":"41400", "Harold Washington Library-State/Van Buren":"40850","LaSalle/Van Buren":"40160","Quincy":"40040",
    "Washington/Wells":"40730","Clark/Lake":"40380","State/Lake":"40260","Randolph/Wabash":"40200",
    "Adams/Wabash":"40680"]
    
let purpleStopIds = ["Linden":"41050","Central":"41250","Noyes":"40400","Foster":"40520","Davis":"40050","Dempster":"40690","Main":"40270","South Blvd":"40840", "Howard":"40900","Wilson":"40540","Sheridan":"40080","Belmont":"41320","Wellington":"41210","Diversey":"40530","Fullerton":"41220","Armitage":"40660","Sedgwick":"40800","Chicago":"40710","Merchandise Mart":"40460", "Clark/Lake":"40380","State/Lake":"40260","Randolph/Wabash":"40200","Adams/Wabash":"40680","Harold Washington Library-State/Van Buren":"40850","LaSalle/Van Buren":"40160","Quincy":"40040","Washington/Wells":"40730"]
    
let pinkStopIds = ["54th/Cermak":"40580","Cicero":"40420","Kostner":"40600","Pulaski":"40150","Central          Park":"40780","Kedzie":"41040","California":"40440","Western":"40740","Damen":"40210","18th":"40830","Polk":"41030","Ashland":"40170","Morgan":"41510","Clinton":"41160","Clark/Lake":"40380",
                       "State/Lake":"40260","Randolph/Wabash":"40200","Adams/Wabash":"40680",
                       "Harold Washington Library-State/Van Buren":"40850",
                       "LaSalle/Van Buren":"40160","Quincy":"40040","Washington/Wells":"40730"]
    
let yellowStopIds = ["Dempster-Skokie":"40140","Oakton-Skokie":"41680","Howard":"40900"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
