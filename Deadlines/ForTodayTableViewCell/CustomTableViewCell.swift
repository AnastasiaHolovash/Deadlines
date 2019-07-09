//
//  CustomTableViewCell.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 6/24/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var showDeadlineLabel: UILabel!
    @IBOutlet weak var proposedTimeLabel: UILabel!
    @IBOutlet weak var checkMarkButton: UIButton!
    
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
        showDeadlineLabel.text = nil
        proposedTimeLabel.text = nil
        
//        let image1 = #imageLiteral(resourceName: "circle_filled-1")
//        checkState = 0
//        checkMarkButton.setImage(image1, for: .normal)

    }
    var checkState = 0
    
    @IBAction func didPressCheckMarkButton(_ sender: UIButton) {
        if checkState == 1{
            let image1 = #imageLiteral(resourceName: "circle_filled-1")
            checkState = 0
            checkMarkButton.setImage(image1, for: .normal)
        }else{
            print(nameLabel.text ?? "NOTHING")
            let image2 = #imageLiteral(resourceName: "checked-2")
            checkState = 1
            checkMarkButton.setImage(image2, for: .normal)
        }
        //checkMarkButton.setImage(image, for: .normal)
    }
    
}
