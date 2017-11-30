//
//  DetailViewController.swift
//  Pravdyvo
//
//  Created by Igor Karyi on 25.11.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artImage: UIImageView!
    @IBOutlet var descrTextView: UITextView!
    
    var contentText: String!
    var contentImage: UIImage!
    var contentDescr: String!
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if contentText != nil {
            self.titleLabel.text = contentText!
        }
        
        if contentImage != nil {
            self.artImage.image = contentImage!
        }
        
        if contentDescr != nil {
            self.descrTextView.text = contentDescr!
        }
    }
}
