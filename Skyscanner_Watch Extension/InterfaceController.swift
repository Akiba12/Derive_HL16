//
//  InterfaceController.swift
//  Skyscanner_Watch Extension
//
//  Created by David Frenkel on 28/02/2016.
//  Copyright © 2016 Samuel Laska. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var button: WKInterfaceButton!
    
    let cities = ["Atlanta, United States", "Beijing, China", "Garhoud, United Arab Emirates", "Chicago, United States", "Tokyo, Japan", "Los Angeles, United States", "Hong Kong, Hong Kong", "Paris, France", "Istanbul, Turkey", "Frankfurt, Germany", "Pudong, China", "Amsterdam, Netherlands", "New York, United States", "Singapore, Singapore", "Denver, United States", "Madrid, Spain", "Las Vegas, United States", "Phoenix, United States", "Sao Paulo, Brazil", "Seoul, South Korea", "Moscow, Russia", "Jakarta, Indonesia", "Mexico City, Mexico", "Lima, Peru", "Bangkok, Thailand", "Tehran, Iran", "Hanoi, Vietnam", "Ankara, Turkey", "Santiago, Chile", "Berlin, Germany", "Bratislava, Slovak Republic", "Prague, Czech Republic", "Rome, Italy", "Stockholm, Sweden", "Bucharest, Romania", "Vienna, Austria", "Budapest, Hungary", "Warsaw, Poland", "Belgrade, Serbia", "Sofia, Bulgaria", "Dublin, Ireland", "Riga, Latvia", "Oslo, Norway", "Helsinki, Finland"]


    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func takeMeAway() {
        let arrayCount = UInt32(cities.count)
        let randomNumber = Int(arc4random_uniform(arrayCount))
        let pick = cities[randomNumber]
        button.setTitle(pick)
        
    }
}
