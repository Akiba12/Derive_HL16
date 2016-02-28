//
//  ViewController.swift
//  Skyscanner
//
//  Created by Samuel Laska on 2/27/16.
//  Copyright © 2016 Samuel Laska. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cities = ["Atlanta, United States", "Beijing, China", "Garhoud, United Arab Emirates", "Chicago, United States", "Tokyo, Japan", "Los Angeles, United States", "Hong Kong, Hong Kong", "Paris, France", "Istanbul, Turkey", "Frankfurt, Germany", "Pudong, China", "Amsterdam, Netherlands", "New York, United States", "Singapore, Singapore", "Denver, United States", "Madrid, Spain", "Las Vegas, United States", "Phoenix, United States", "Sao Paulo, Brazil", "Seoul, South Korea", "Moscow, Russia", "Jakarta, Indonesia", "Mexico City, Mexico", "Lima, Peru", "Bangkok, Thailand", "Tehran, Iran", "Hanoi, Vietnam", "Ankara, Turkey", "Santiago, Chile", "Berlin, Germany", "Bratislava, Slovak Republic", "Prague, Czech Republic", "Rome, Italy", "Stockholm, Sweden", "Bucharest, Romania", "Vienna, Austria", "Budapest, Hungary", "Warsaw, Poland", "Belgrade, Serbia", "Sofia, Bulgaria", "Dublin, Ireland", "Riga, Latvia", "Oslo, Norway", "Helsinki, Finland"]
    
    var places = [String]()
    var friends = [String]()
    
    var selected = ""
    var position = 0
    
    let decode = Decode()
    @IBOutlet weak var subtitleLabe: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        super.viewDidLoad()
        
        performSegueWithIdentifier("showFacebook", sender: self)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("mainCell") as? MainTableViewCell else {
            fatalError("main cell failed to intiliaze")
        }
        guard let cityName = cities[indexPath.row] as? String else { fatalError("out of bounds for cities") }
        
        cell.cityNameLabel.text = cityName
        let code = decode.cityToIATA(cityName)
        cell.heroImage.image = UIImage(named: "\(code)-banner")
        cell.firstImage.image = UIImage(named: "\(indexPath.row+1)")
        cell.firstImage.layer.cornerRadius = 25
        cell.firstImage.clipsToBounds = true
        cell.firstImage.layer.borderWidth = 2
        cell.firstImage.layer.borderColor = UIColor.whiteColor().CGColor
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected \(indexPath.row)")
        if let city = cities[indexPath.row] as? String {
            selected = city
            position = indexPath.row
            performSegueWithIdentifier("showDetail", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detail = segue.destinationViewController as? DetailViewController {
            detail.globalTestLocation = selected
            detail.position = position+1
        } else if let facebook = segue.destinationViewController as? FacebookViewController {
            facebook.delegate = self
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func calculateTravelStats() {
        subtitleLabe.text = "We found \(cities.count) undiscovered locations"
        print("places: \(places.count) friends: \(friends.count)")
    }
}

