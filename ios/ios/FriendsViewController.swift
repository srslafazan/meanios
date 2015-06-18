//
//  FriendsViewController.swift
//  ios
//
//  Created by Shain Lafazan on 6/17/15.
//  Copyright (c) 2015 Shain Lafazan. All rights reserved.
//

import Foundation
import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBAction func insertButtonPressed(sender: UIButton) {
        
        if let urlToReq = NSURL(string: "http://192.168.1.7:8000/friends") {
            
            var request: NSMutableURLRequest = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            var bodyData = "name=\(nameTextField.text)&age=\(ageTextField.text)"
    
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);

            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response, data, error) in
            }
        }
    }
}