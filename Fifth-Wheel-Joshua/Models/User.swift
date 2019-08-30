//
//  User.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation


class User: Codable, Equatable {
    
    var id:         UUID = UUID()
    var username:   String
    var password:   String
    var landowner:  Bool?
    var imageURL:   String?
    var bio:        String?
    var token:      Bearer?
    var listings:   [Listing]?
    var bookings:   [Booking]?
    
    init(username: String, password: String, landowner: Bool? = false, imageURL: String? = nil, bio: String? = nil) {
        self.username   = username
        self.password   = password
        self.landowner  = landowner
        self.imageURL   = imageURL
        self.bio        = bio
    }
}

extension User {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Bearer: Codable {
    var token: String
}
