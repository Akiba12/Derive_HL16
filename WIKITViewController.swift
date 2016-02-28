//
//  ViewController.swift
//  JSON
//
//  Created by Jakub on 27/02/2016.
//  Copyright © 2016 Jakub. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let cityPreCheck = "Hong Kong"
        let city = cityPreCheck.stringByReplacingOccurrencesOfString(" ", withString: "_")
        Alamofire.request(.GET, "https://en.wikivoyage.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&titles=" + city + "&formatversion=2&redirects").validate().responseJSON { response in
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

