//
//  Booking.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class Booking: Codable, Equatable {
    
    

    var id: UUID = UUID()
    let listingId: UUID
    let userId: UUID
    let listedBy: UUID
    var startDate: String
    var stopDate: String
    var listing: Listing {
        let listings = listingController.listings.filter({$0.id == self.listingId})
        return listings[0]
    }

    init(listingId: UUID, userId: UUID, startDate: String, stopDate: String, listedBy: UUID) {
        
        self.listingId = listingId
        self.userId = userId
        self.startDate = startDate
        self.stopDate = stopDate
        self.listedBy = listedBy
    }
}

extension Booking {
    static func == (lhs: Booking, rhs: Booking) -> Bool {
        return lhs.id == rhs.id
    }
}
