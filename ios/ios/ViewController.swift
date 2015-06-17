//
//  ViewController.swift
//  ios
//
//  Created by Shain Lafazan on 6/17/15.
//  Copyright (c) 2015 Shain Lafazan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let urlToReq = NSURL(string: "http://localhost:8000/friends") {
            if let data = NSData(contentsOfURL: urlToReq) {
                let arrOfFriends = parseJSON(data)
                
                for friend in arrOfFriends {
                    let object = friend as! NSDictionary
                    
                    let friendName = object["name"] as! String
                    let friendAge = object["age"] as! Int
                    
                    let friend = Friend(name: friendName, age: friendAge)
                    friends.append(friend)
                }
            }
        }
    }
    
    func parseJSON(inputData: NSData) -> NSArray {
        var error: NSError?
        var arrOfObjects = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        return arrOfObjects
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

