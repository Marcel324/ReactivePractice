//
//  GOTTableViewCell.swift
//  ReactivePractice
//
//  Created by Marcel Chaucer on 12/6/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit

class GOTTableViewCell: UITableViewCell {
    @IBOutlet weak var houseTitleLabel: UILabel!
    @IBOutlet weak var houseRegionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
