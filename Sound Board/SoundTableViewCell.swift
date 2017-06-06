//
//  SoundTableViewCell.swift
//  Sound Board
//
//  Created by Zeean Veljee on 06/06/17.
//  Copyright © 2017 Zed. All rights reserved.
//

import UIKit

class SoundTableViewCell: UITableViewCell {

    @IBOutlet weak var soundNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
