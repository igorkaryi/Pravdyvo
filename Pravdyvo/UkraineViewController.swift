//
//  UkraineViewController.swift
//  Pravdyvo
//
//  Created by Igor Karyi on 25.11.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UkraineViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var nameTitle = [String]()
    var contentTitle = [String]()
    var imageTitle = [String]()
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
        self.addSlideMenuButton()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Оновлення інформації")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject) {
        loadNews()
    }

    func loadNews() {
        Alamofire.request("http://pravdyvo.com/archives/category/ukraine?json=1", method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    let json = JSON(data: response.data!)
                    if let posts = json["posts"].array {
                        for item in posts {
                            if let title = item["title"].string {
                                print(title)
                                self.nameTitle.append(title)
                            }
                            if let content = item["content"].string {
                                print(content)
                                let str = content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) // - убрать теги
                                self.contentTitle.append(str)
                            }
                            if let image = item["thumbnail_images"]["medium_large"]["url"].string {
                                print(image)
                                self.imageTitle.append(image)
                            }
                            self.tableView.reloadData()
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                    }
                }
                else {
                    debugPrint("HTTP Request failed: \(String(describing: response.result.error))")
                }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UkraineCell
        cell.titleLabel?.text = nameTitle[indexPath.row]
        cell.contentLabel?.text = contentTitle[indexPath.row]
        cell.imageArt.downloadImage(from: (imageTitle[indexPath.item]))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailAllNews" {
            let detailVC: DetailViewController? = segue.destination as? DetailViewController
            let cell: UkraineCell? = sender as? UkraineCell
            
            if cell != nil && detailVC != nil {
                detailVC?.contentDescr = cell?.contentLabel!.text
                detailVC?.contentText = cell?.titleLabel!.text
                detailVC?.contentImage = cell?.imageArt!.image
            }
        }
    }
}
