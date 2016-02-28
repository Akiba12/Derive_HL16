//
//  DetailViewController.swift
//  Skyscanner
//
//  Created by Samuel Laska on 2/27/16.
//  Copyright © 2016 Samuel Laska. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PPKControllerDelegate {

    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var flightsButton: UnderlineButton!
    @IBOutlet weak var wikiButton: UnderlineButton!
    
    @IBOutlet weak var profile1: UIImageView!
    @IBOutlet weak var profile2: UIImageView!
    @IBOutlet weak var profile3: UIImageView!
    @IBOutlet weak var profile4: UIImageView!
    @IBOutlet weak var profile5: UIImageView!
    
    let key = "eyJzaWduYXR1cmUiOiJjNzRqaWpJR2ZEb3k1c2dwcnkxa004VmxFY1FKS3RZb25jZG5QQ3VZRi9mSW54bXhoRmgvdW5sVEc2NC93VTQwRlBPaG9mbzQ5YjZpT1lQZjFOWEFVTlJLUGNUUTJ0K0tQTVRYcTNJSGFjOWNwOE54TEgvVXROTlNEUW9GeGxBRnBySFNoU1k0QU1Wd3RZcmtkSkFqby84ZTdRSktTZVNXQW1ucS9BQmhVYmc9IiwiYXBwSWQiOjE0NTIsInZhbGlkVW50aWwiOjE2OTQ5LCJhcHBVVVVJRCI6IkRBNjc3QkM4LUE2REUtNEI2Ri04MjlGLUUzMzJGRThDREE5MCJ9"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var globalDataArray = [Dictionary<String, String>]()
    var globalTestLocation = "Budapest, Hungary"
    var position = 0
    
    let decode = Decode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        PPKController.enableWithConfiguration(key, observer:self)

        
        let wiki = WikiData()
        wiki.getDataFromWiki("dfxgchvjbknm")
        
        checkFlight(globalTestLocation) { (array) -> Void in
            self.globalDataArray = array
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        }
        
        let code = decode.cityToIATA(globalTestLocation)
        
        locationImage.image = UIImage(named: "\(code)-banner")
        locationTitle.text  = globalTestLocation
        countryFlag.image   = UIImage(named: "\(code)-flag")
        countryFlag.layer.cornerRadius = countryFlag.frame.size.height/2
        countryFlag.clipsToBounds = true
        
        flightsButton.selected = true
        
        // MapView
        mapView.hidden = true
        let geocoder: CLGeocoder = CLGeocoder()
        let location = globalTestLocation
        geocoder.geocodeAddressString(location,completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            if (placemarks?.count > 0) {
                let topResult: CLPlacemark = (placemarks?[0])!
                let placemark: MKPlacemark = MKPlacemark(placemark: topResult)
                var region: MKCoordinateRegion = self.mapView.region
                region.center = (placemark.region as! CLCircularRegion).center
                region.span.longitudeDelta /= 250
                region.span.latitudeDelta /= 250
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(placemark)
            }
        })
        
        
        // table
        tableView.delegate   = self
        tableView.dataSource = self
        
        
        // profile images
        profile1.image = UIImage(named: "\(position)")
        profile2.image = UIImage(named: "\(position+1)")
        profile3.image = UIImage(named: "\(position+2)")
        profile4.image = UIImage(named: "\(position+3)")
        profile5.image = UIImage(named: "\(position+4)")
        
        let diceRoll = Int(arc4random_uniform(3) + 1)
        
        switch diceRoll {
            case 1:
            profile5.hidden = true
            profile4.hidden = true
        case 2:
            profile5.hidden = true
            profile4.hidden = true
        case 3:
            profile5.hidden = true
            profile4.hidden = true
            profile3.hidden = true
        default: break
        }
        
        let radius = profile1.frame.size.height/2
        profile1.layer.cornerRadius = radius
        profile1.clipsToBounds = true
        profile2.layer.cornerRadius = radius
        profile2.clipsToBounds = true
        profile3.layer.cornerRadius = radius
        profile3.clipsToBounds = true
        profile4.layer.cornerRadius = radius
        profile4.clipsToBounds = true
        profile5.layer.cornerRadius = radius
        profile5.clipsToBounds = true
        
        // shadow
        let l = shadowView.layer
        l.shadowColor = UIColor.blackColor().CGColor
        l.shadowOffset = CGSize(width: 0, height: 2)
        l.shadowOpacity = 0.2
        l.shadowRadius = 2
        
        // swipe
//        let swipe = UISwipeGestureRecognizer(target: self, action: "swiped:")
//        overlayView.addGestureRecognizer(swipe)
    }
    
    func swiped(gesture:UIGestureRecognizer) {
        if let gesture = gesture as? UISwipeGestureRecognizer {
            switch gesture.direction {
                case UISwipeGestureRecognizerDirection.Right:   selectTab(flightsButton)
                case UISwipeGestureRecognizerDirection.Left:    selectTab(wikiButton)
                default: return
            }
        }
    }
    
    

    @IBAction func selectTab(sender: UIButton) {
        let wikiOn = sender == wikiButton
        wikiButton.selected = wikiOn
        flightsButton.selected = !wikiOn
        mapView.hidden = !wikiOn
        countryFlag.hidden = wikiOn
        locationTitle.hidden = wikiOn
    }
    
    
    // MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if globalDataArray.count < 1 {
            return 60
        } else {
            return globalDataArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("flightCell") as! FlightTableViewCell
        if globalDataArray.count < 1 {
            cell.titleLabel.text = "--"
        } else {
            let currentFlight = globalDataArray[indexPath.row]
            cell.titleLabel.text = currentFlight["price"]
            if let date = currentFlight["Outbound_Deperature_Date"] {
               let d = date.stringByReplacingOccurrencesOfString("T00:00:00", withString: "").stringByReplacingOccurrencesOfString("2016-", withString: "")
                cell.dateLabel.text = d
            } else {
                cell.dateLabel.text = "--"
            }
            cell.companyLabel.text = currentFlight["Outbound_Carrier"]
            cell.directLabel.text = currentFlight["direct"]
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    //MARK: - LOADING DATA FROM SERVER
    
    func checkFlight(whereRaw: String, block:(Array<Dictionary<String, String>> -> Void)){
        
        let whereTo = decode.cityToIATA(whereRaw)
        
        let network = Networking()
        var flightsData = [Array<AnyObject>]()
        var mainDataDictArray = [Dictionary<String, String>]()
        network.to = whereTo
        network.from = "LHR"
        network.getData { (places, carrier, quotes) -> Void in
            
            for flights in quotes {
                guard let flights = flights as? [AnyObject] else { print("guard used");  continue }
                
                var mainDataDictionary = [String:String]()
                //print(flights)
                //direct?
                let data1 = flights[0] as! Int
                var direct = ""
                if data1 == 0 {
                    direct = "Indirect Flight"
                } else {
                    direct = "Direct Flight"
                }
                mainDataDictionary["direct"] = direct
                
                //price?
                let data2 = flights[1]
                mainDataDictionary["price"] = "£\(data2)"
                
                //carriers outbound
                let outboundC = flights[2] as! Array<Int>
                var ocText = ""
                if outboundC.count == 1 {
                    let value = outboundC[0]
                    ocText = carrier[value]!
                } else {
                    ocText = "Multiple Carriers"
                }
                mainDataDictionary["Outbound_Carrier"] = ocText
                
                //carriers inbound
                let inboundC = flights[3]as! Array<Int>
                var icText = ""
                if inboundC.count == 1 {
                    let value = inboundC[0]
                    icText = carrier[value]!
                } else {
                    icText = "Multiple Carriers"
                }
                mainDataDictionary["Inbound_Carrier"] = icText
                
                //deperature date out
                let depDateOut = flights[4] as! String
                print(depDateOut)
                mainDataDictionary["Outbound_Deperature_Date"] = depDateOut
                
                //departure date in
                let depDateIn = flights[5] as! String
                mainDataDictionary["Inbound_Deperature_Date"] = depDateIn
                
                //destination id out
                let destIdOut = flights[6] as! Int
                let dst = places[destIdOut]
                let dioText = "\(dst![0]), \(dst![1])"
                mainDataDictionary["DestinationIdOut"] = dioText
                
                
                //destinagion id in
                let destIdIn = flights[7] as! Int
                let dsdID = places[destIdIn]
                let diiText = "\(dsdID![0]), \(dsdID![1])"
                mainDataDictionary["DestinationIdIn"] = diiText
                
                //origin id out
                let originIdOut = flights[8] as! Int
                let oidOut = places[originIdOut]
                let oidText = "\(oidOut![0]), \(oidOut![1])"
                mainDataDictionary["OriginIdOut"] = oidText
                
                
                //origin id in
                let originIdIn = flights[9] as! Int
                let oidIn = places[originIdIn]
                let oidInText = "\(oidIn![0]), \(oidIn![1])"
                mainDataDictionary["OriginIdIn"] = oidInText
                
                mainDataDictArray.append(mainDataDictionary)
            }
            block(mainDataDictArray)
        }
        
    }
    
    func PPKControllerInitialized() {
        PPKController.startP2PDiscoveryWithDiscoveryInfo(nil);
    }
    func p2pPeerDiscovered(peer: PPKPeer!) {
        let discoveryInfoString = NSString(data: peer.discoveryInfo, encoding:NSUTF8StringEncoding)
        NSLog("%@ is here with discovery info: %@", peer.peerID, discoveryInfoString!)
    }
    
    func p2pPeerLost(peer: PPKPeer!) {
        NSLog("%@ is no longer here", peer.peerID)
    }

    @IBAction func goBack() {
        navigationController?.popToRootViewControllerAnimated(true)
    }

}
