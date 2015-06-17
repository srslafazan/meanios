//
//  ViewController.swift
//  ios
//
//  Created by Shain Lafazan on 6/17/15.
//  Copyright (c) 2015 Shain Lafazan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDataSource {

    var friends = [Friend]()
    
    override func viewDidLoad() {
        println("hi")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let urlToReq = NSURL(string: "http://192.168.1.125:8000/friends") {
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
        println(arrOfObjects)
        return arrOfObjects
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let dequeued: AnyObject = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)
            
            let cell = dequeued as! FriendCell
            let friend = friends[indexPath.row]
            
            cell.friendName.text = friend.friendName
            cell.friendAge.text = String(stringInterpolationSegment: friend.friendAge)
        
            return cell

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

