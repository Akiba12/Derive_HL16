//
//  FacebookViewController.swift
//  Skyscanner
//
//  Created by Samuel Laska on 2/28/16.
//  Copyright © 2016 Samuel Laska. All rights reserved.
//

import UIKit

class FacebookViewController: UIViewController {

    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var subLabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var delegate: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.stopAnimating()
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        
        let login = FBSDKLoginManager()
        login.logInWithReadPermissions(["public_profile", "email", "user_posts", "user_friends", "user_tagged_places"], fromViewController: self) { (result, error) -> Void in
            if error != nil {
                print("process error")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else if result.isCancelled {
                print("login cancelled")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.traversePlaces(nil)
                self.spinner.startAnimating()
            }
        }
        
    }
    
    
    
    func traversePlaces(nextCursor: String?) {
        var parameters = ["fields" : "place, id"]
        if let cursor = nextCursor {
            parameters["after"] = cursor
        }
        
        subLabel.text = "Learning about where have you been"
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            FBSDKGraphRequest(graphPath: "me/tagged_places", parameters: parameters).startWithCompletionHandler({ (connection, result, error) -> Void in
                if error == nil {
                    if let resultdict = result as? NSDictionary,
                        let data = resultdict.objectForKey("data") as? NSArray {
                        
                        for i in 0..<data.count {
                            let valueDict : NSDictionary = data[i] as! NSDictionary
                            //                            let id = valueDict.objectForKey("id") as! String
                            //                            let created_time = valueDict.objectForKey("created_time") as! NSDate
                            let placeDict = valueDict.objectForKey("place") as! NSDictionary
                            let locationDict = placeDict.objectForKey("location") as! NSDictionary
                            let city = locationDict.objectForKey("city") as! String
                            //                            let name = placeDict.objectForKey("name") as! String
//                            print(": \(city)")
                            self.delegate?.places.append(city)
                        }
                    }
                    
                    if let after = ((result.objectForKey("paging") as? NSDictionary)?.objectForKey("cursors") as? NSDictionary)?.objectForKey("after") as? String {
//                        print("- next")
                        self.traversePlaces(after)
                    } else {
//                        print("- end")
                        self.traverseFriends(nil)
                    }
                }
            })
        }
    }
    
    func traverseFriends(nextCursor: String?) {
        var parameters = ["fields" : "name, picture"]
        if let cursor = nextCursor {
            parameters["after"] = cursor
        }
        
        subLabel.text = "Locating your friends around the globe"
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            FBSDKGraphRequest(graphPath: "me/taggable_friends", parameters: parameters).startWithCompletionHandler({ (connection, result, error) -> Void in
                if error == nil {
                    if let resultdict = result as? NSDictionary,
                        let data = resultdict.objectForKey("data") as? NSArray {
                        
                        for i in 0..<data.count {
                            let valueDict : NSDictionary = data[i] as! NSDictionary
                            let name     = valueDict.objectForKey("name") as! String
                            let pictDict = valueDict.objectForKey("picture") as! NSDictionary
                            //                            let dataDict = pictDict.objectForKey("data") as! NSDictionary
                            //                            let url = dataDict.objectForKey("url") as! String
//                            let randomIndex = Int(arc4random_uniform(UInt32(self.delegate?.cities.count)))
//                            let city = self.cities[randomIndex]
//                            print("> \(name) : \(city)")
                            self.delegate?.friends.append(name)
                        }
                    }
                    
                    if let after = ((result.objectForKey("paging") as? NSDictionary)?.objectForKey("cursors") as? NSDictionary)?.objectForKey("after") as? String {
                        self.traverseFriends(after)
                    } else {
                        self.delegate?.calculateTravelStats()
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
            })
        }
    }
    @IBAction func dismissTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
