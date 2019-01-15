//
//  ViewController.swift
//  alomofire_2
//
//  Created by Felix-ITS 004 on 15/01/19.
//  Copyright © 2019 hrishi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var arrRes = [[String:AnyObject]]() //Array of dictionary

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        var dict = arrRes[indexPath.row]
        cell.textLabel?.text = dict["name"] as? String
        cell.detailTextLabel?.text = dict["email"] as? String
        return cell
   
    }
    

    @IBOutlet var tblvwdata: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblvwdata.delegate = self
        tblvwdata.dataSource = self
    
        Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["contacts"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.tblvwdata.reloadData()
                }
            }
        // Do any additional setup after loading the view, typically from a nib.
    }
}
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

