//
//  Listing.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

class Listing: Codable, Equatable {
    
    var id:             UUID = UUID()
    var userId:         UUID
    var name:           String
    var description:    String
    var imageUrl:       String?
    var address:        String?
    
    init(userId: UUID, name: String, description: String, imageUrl: String? = nil, address: String? = nil) {
        self.userId         = userId
        self.name           = name
        self.description    = description
        self.imageUrl       = imageUrl
        self.address        = address
    }
}

extension Listing {
    static func == (lhs: Listing, rhs: Listing) -> Bool {
        return lhs.id == rhs.id
    }
}
