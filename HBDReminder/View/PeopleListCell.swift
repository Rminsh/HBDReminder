//
//  PeopleListCell.swift
//  HBDReminder
//
//  Created by armin on 11/7/19.
//  Copyright © 2019 shalchian. All rights reserved.
//

import UIKit

class PeopleListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var turningLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI (items : Birthday) {
        nameLabel.text = items.name
        dateLabel.text = items.date?.toString(dateFormat: "YYYY/MM/dd")
        let days = calculateDaysLeft(birthday: items.date!)
        var status : String = ""
        if (days == "365" || days == "366") {
            status = "Happy birthday 🎉"
        } else {
            status = "\(days) days left"
        }
        turningLabel.text = "turning \(calculateAge(birthday: items.date!)+1) , \(status)"
    }
}
