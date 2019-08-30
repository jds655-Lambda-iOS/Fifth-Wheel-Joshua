//
//  AccountListingTableViewCell.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class AccountListingTableViewCell: UITableViewCell {
    var listing: Listing? {
        didSet{
            updateViews()
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        nameLabel.text = listing?.name
        descriptionLabel.text = listing?.description
    }

}
