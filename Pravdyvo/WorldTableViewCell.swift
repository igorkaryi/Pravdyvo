//
//  WorldTableViewCell.swift
//  Pravdyvo
//
//  Created by Igor Karyi on 25.11.2017.
//  Copyright © 2017 Igor Karyi. All rights reserved.
//

import UIKit

class WorldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageArt: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
