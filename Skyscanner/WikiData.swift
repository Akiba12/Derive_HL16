//
//  WikiData.swift
//  Skyscanner
//
//  Created by David Frenkel on 28/02/2016.
//  Copyright © 2016 Samuel Laska. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WikiData: NSObject {
    
    func getDataFromWiki(cityName: String){
        let cityPreCheck = "Hong Kong"
        let city = cityPreCheck.stringByReplacingOccurrencesOfString(" ", withString: "_")
    
    
        let alamoFire = Alamofire.request(.GET, "https://en.wikivoyage.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&titles=\(city)&formatversion=2&redirects").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    //print("JSON: \(json)")
                    let json2 = json["query"]["pages"][0]["extract"]
                    print(json2)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
}
