//
//  TimeLeftTableViewCell.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 7/3/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class TimeLeftTableViewCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        
    }
    
}
