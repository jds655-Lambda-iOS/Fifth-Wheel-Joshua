//
//  Booking Controller.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

var bookingController = BookingController()

class BookingController {
    private(set) var bookings: [Booking] = []
    var userListingBookings: [Booking] {
        var list: [Booking] = []
        for booking in bookings {
            for listingId in listingController.userListingIds {
                if booking.listingId == listingId { list.append(booking)}
            }
        }
        return list
    }
    var userBookings: [Booking] {
        guard let userId = userController.loggedInUser?.id else {return []}
        return bookings.filter({$0.userId == userId})
    }
    
    init () {
        loadFromPersistentStore()
    }
    
    func add (listing: Listing, userId: UUID, startDate: String, stopDate: String) {
        let newBooking = Booking(listingId: listing.id, userId: (userController.loggedInUser?.id)!, startDate: startDate, stopDate: stopDate, listedBy: listing.userId)
        bookings.append(newBooking)
        saveToPersistentStore()
    }
    
    func delete (which booking: Booking) {
        guard let index = bookings.firstIndex(of: booking) else { return }
        bookings.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - File Persistence Private Methods and Constants
    private let storeContentName: String = "Bookings"
    private let storeContentFile: String = "bookings.plist"
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        //IE /Users/paulsolt/Documents
        //IE /Users/paulsolt/Documents/stars.plist
        
        return documents.appendingPathComponent(storeContentFile)
    }
    
    private func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(bookings)
            try data.write(to: url)
        } catch {
            print("Error saving \(storeContentName) data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            bookings = try decoder.decode([Booking].self, from: data)
        } catch {
            print("Error loading \(storeContentName) data: \(error)")
        }
    }
}
