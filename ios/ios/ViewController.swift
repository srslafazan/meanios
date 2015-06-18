//
//  ViewController.swift
//  ios
//
//  Created by Shain Lafazan on 6/17/15.
//  Copyright (c) 2015 Shain Lafazan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDataSource {

    @IBAction func insertNewFriendAndGoBackToFriends(segue:UIStoryboardSegue) {
        
        let sourceVC = segue.sourceViewController as! FriendsViewController
        
        // create new instance of Friend and append to the Friend Array
        let friend = Friend(name: sourceVC.nameTextField.text, age: sourceVC.ageTextField.text.toInt())
        friends.append(friend)
        
        tableView.reloadData()
    }
    
    var friends = [Friend]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if let urlToReq = NSURL(string: "http://192.168.1.7:8000/friends") {

            if let data = NSData(contentsOfURL: urlToReq) {
                let arrOfFriends = parseJSON(data)
                for friend in arrOfFriends {
                    
                    if let object = friend as? NSDictionary {
                        if let friendName = object["name"] as? String {
                            if let friendAge = object["age"] as? Int {
                                let friend = Friend(name: friendName, age: friendAge)
                                friends.append(friend)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func parseJSON(inputData: NSData) -> NSArray {
        var error: NSError?
        var arrOfObjects = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
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