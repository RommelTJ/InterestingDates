//
//  IDTableViewCell.swift
//  InterestingDates
//
//  Created by Rommel Rico on 4/29/16.
//  Copyright © 2016 Rommel Rico. All rights reserved.
//

import UIKit

class IDTableViewCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
