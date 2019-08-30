//
//  Listing Controller.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

var listingController = ListingController()

class ListingController {
    // MARK: - Variables/Contants
    var listings: [Listing] = []
    var userListings: [Listing] {
        guard let userId = userController.loggedInUser?.id else {return []}
        return listings.filter({$0.userId == userId})
    }
    
    @discardableResult func add (listing: Listing) -> Listing {
        let newlisting = Listing(userId: listing.userId, name: listing.name,
            description: listing.description,
            imageUrl: listing.imageUrl ?? "",
            address: listing.address ?? "")
        listings.append(newlisting)
        saveToPersistentStore()
        return newlisting
    }
    
    func delete (which listing: Listing) -> Bool {
        guard let index = listings.firstIndex(of: listing) else { return false}
        listings.remove(at: index)
        saveToPersistentStore()
        return true
    }
    
    func update (which listing: Listing) -> Bool {
        guard let index = listings.firstIndex(of: listing) else { return false }
        listings[index].name = listing.name
        listings[index].description = listing.description
        if let imageUrl = listing.imageUrl { listings[index].imageUrl = imageUrl }
        if let address = listing.address { listings[index].address = address }
        saveToPersistentStore()
        return true
    }
    

    // MARK: - File Persistence Private Methods and Constants
    private let storeContentName: String = "Listings"
    private let storeContentFile: String = "listings.plist"

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
            let data = try encoder.encode(listings)
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
            listings = try decoder.decode([Listing].self, from: data)
        } catch {
            print("Error loading \(storeContentName) data: \(error)")
        }
    }
}
