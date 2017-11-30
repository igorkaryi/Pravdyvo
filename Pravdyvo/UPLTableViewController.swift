//
//  UPLTableViewController.swift
//  Pravdyvo
//
//  Created by Igor Karyi on 25.11.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UPLTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameTitle = [String]()
    var pointsTitle = [String]()
    var gameTitle = [String]()
    var placeTitle = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableUPL()
    }
    @IBAction func refreshBtn(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    func loadTableUPL() {
        Alamofire.request("http://pravdyvo.com/table_upl.html", method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let json = JSON(data: response.data!)
                    print(json)
                    if let posts = json[].array {
                        for item in posts {
                            if let place = item["№"].string {
                                print(place)
                                self.placeTitle.append(place)
                            }
                            if let name = item["Команда"].string {
                                print(name)
                                self.nameTitle.append(name)
                            }
                            if let game = item["І"].string {
                                print(game)
                                self.gameTitle.append(game)
                            }
                            if let points = item["О"].string {
                                print(points)
                                self.pointsTitle.append(points)
                            }
                            self.tableView.reloadData()
                }
                    }
                        
                else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                }
        }
    }
}
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.nameTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UPLCell
        cell.placeLabel?.text = self.placeTitle[indexPath.row]
        cell.nameLAbel?.text = nameTitle[indexPath.row]
        cell.gameLabel?.text = self.gameTitle[indexPath.row]
        cell.pointsLabel?.text = pointsTitle[indexPath.row]
        return cell
    }
}
