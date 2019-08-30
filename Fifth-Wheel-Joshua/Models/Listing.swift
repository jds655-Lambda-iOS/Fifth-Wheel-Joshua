//
//  Listing.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class Listing: Codable {
    
    var listingId:      Int?
    var userId:         Int?
    var listingName:    String
    var description:    String
    var imageUrl:       String?
    var address:        String?
    
    init(userId: Int, listingName: String, description: String) {
        self.userId         = userId
        self.listingName    = listingName
        self.description    = description
    }
}
