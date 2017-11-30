//
//  UPLCell.swift
//  Pravdyvo
//
//  Created by Igor Karyi on 25.11.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit

class UPLCell: UITableViewCell {

    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var nameLAbel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
