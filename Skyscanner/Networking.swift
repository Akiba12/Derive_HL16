//
//  Networking.swift
//  sssapp
//
//  Created by David Frenkel on 27/02/2016.
//  Copyright © 2016 sssapp. All rights reserved.
//
import UIKit
import Alamofire
class Networking: NSObject {
    var to: String = ""
    var from: String = ""
    //main call to servers
    func getData(block: ((places: Dictionary<Int, Array<String>>, carrier: Dictionary<Int, String>, quotes: Array<AnyObject>) -> Void)){
        
        let alamofire = Alamofire.request(.GET, "http://partners.api.skyscanner.net/apiservices/browsequotes/v1.0/UK/GBP/en-GB/\(from)/\(to)/2016-03/2016-04", parameters: ["apiKey" : "ah317504417108291477967241874893"], headers: ["Content-Type": "application/json"]).responseJSON {
            response in
            if response.result.isSuccess {
                let jsonDic = response.result.value as! NSDictionary
                
                if let placesDict = jsonDic["Places"],  let quotesDict = jsonDic["Quotes"], let carriersDict = jsonDic["Carriers"]{
                    
                    let first = self.placesDeconsturct(placesDict)
                    let second = self.carriersDeconstruct(carriersDict)
                    let third = self.quotesDeconstruct(quotesDict)
                    block(places: first, carrier: second, quotes: third)
                } else {
                    block(places: [0 : ["error"]], carrier: [0 : "Error"], quotes: ["Error"])
                    
                }
                
            }
            
            
        }
    }
    
    
    func quotesDeconstruct(quotsDict: AnyObject) ->Array<AnyObject>{
        let local = quotsDict as! Array<AnyObject>
        var qDict = [Int: Array<AnyObject>]()
        var qArrays = [Array<AnyObject>]()
        
        for data in local {
            
            let direct = data["Direct"] as! Int
            let price = data["MinPrice"] as! Int
            let qi = data["QuoteId"] as! Int
            
            let ob = data["OutboundLeg"]
            let carOb = ob!!["CarrierIds"] as! Array<Int>
            let ddOb = ob!!["DepartureDate"] as! String
            let diOb = ob!!["DestinationId"] as! Int
            let oiOb = ob!!["OriginId"] as! Int
            
            let ib = data["InboundLeg"]
            let carIb = ib!!["CarrierIds"] as! Array<Int>
            let ddIb = ib!!["DepartureDate"] as! String
            let diIb = ib!!["DestinationId"] as! Int
            let oiIb = ib!!["OriginId"] as! Int
            
            let datArray = [direct, price, carOb, carIb, ddOb, ddIb, diOb, diIb, oiOb, oiIb] as Array<AnyObject>
            qArrays.append(datArray)
            qDict[qi] = (datArray as Array<AnyObject>)
            
        }
        
        return qArrays
    }
    
    
    func placesDeconsturct(placesDict: AnyObject) ->Dictionary<Int, Array<String>>{
        var placesData = [Int: Array<String>]()
        let local = placesDict as! Array<AnyObject>
        
        for data in local {
            let placeID = data["PlaceId"] as! Int
            let cityName = data["CityName"] as! String
            let countryName = data["CountryName"] as! String
            let value = [cityName, countryName]
            placesData[placeID] = value
        }
        return placesData
    }
    
    
    //get dictionary which has airlines numbers mathched to airline names
    func carriersDeconstruct(carriers: AnyObject) ->Dictionary<Int, String>{
        var carrierData = [Int: String]()
        
        let local = carriers as! Array<AnyObject>
        for data in local {
            
            let key = data["CarrierId"] as! Int
            let value = data["Name"] as! String
            carrierData[key] = value
        }
        
        return carrierData
    }
}