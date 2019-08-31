//
//  BookingsTableViewCell.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/31/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class BookingsTableViewCell: UITableViewCell {
    var booking: Booking?{
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var bookedByLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    
    private func updateViews() {
        guard let booking = booking else { return }
        siteNameLabel.text = booking.listing.name
        bookedByLabel.text = userController.getName(from: booking.userId)
        arrivalLabel.text = booking.startDate
        departureLabel.text = booking.stopDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
