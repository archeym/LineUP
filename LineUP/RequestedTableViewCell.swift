//
//  RequestedTableViewCell.swift
//  LineUP
//
//  Created by ardMac on 18/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import UIKit

class RequestedTableViewCell: UITableViewCell {
    static let cellIdentifier = "RequestedTableViewCell"
    static let cellNib = UINib(nibName: RequestedTableViewCell.cellIdentifier, bundle: Bundle.main)
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var leaveLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var numberOfDaysLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
