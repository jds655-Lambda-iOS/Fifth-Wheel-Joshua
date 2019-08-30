//
//  Booking.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class Booking: Codable {

    var bookingId: Int?
    let listingId: Int
    let userId: Int
    let listedBy: String
    var startDate: Date
    var stopDate: Date

    init(listingId: Int, userId: Int, startDate: Date, endDate: Date, listedBy: String) {
        
        self.listingId = listingId
        self.userId = userId
        self.startDate = startDate
        self.stopDate = endDate
        self.listedBy = listedBy
    }
}
