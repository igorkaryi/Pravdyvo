//
//  LCViewController.swift
//  Pravdyvo
//
//  Created by Igor Karyi on 26.11.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadleagueTable()
    }

    func loadleagueTable() {
        Alamofire.request("http://api.football-data.org/v1/soccerseasons/464/leagueTable", method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let json = JSON(data: response.data!)
                    print(json)
                    if let posts = json[].array {
                        for item in posts {
                            if let place = item["leagueCaption"].string {
                                print(place)
                            }
                        }
                    }
                        
                    else {
                        debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                    }
                }
        }
    }

}
