//
//  User Controller.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/29/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation
var userController = UserController()

class UserController {
    // MARK: - Variables/Contants
    
    private(set) var users: [User] = []
    var loggedInUser: User?
    
    // MARK: - Methods
    init () {
        loadFromPersistentStore()
    }
    
    func login (with user: User) -> Bool {
        var result: Bool = false
        for u in users {
            if u.username == user.username {
                if u.password == user.password {
                    self.loggedInUser = u
                    result = true
                }
            }
        }
        return result
    }
    
    func register (with user: User) -> Bool {
        var result: Bool = false
        var alreadyReg: Bool = false
        for u in users {
            alreadyReg = u.username == user.username
        }
        if !alreadyReg {
            let newuser = self.add(user: user)
            result = login(with: newuser)
        } else {
            result = false
        }
        return result
    }
    
    @discardableResult func add (user: User) -> User {
        let newuser = User(username: user.username, password: user.password, landowner: user.landowner, imageURL: user.imageURL, bio: user.bio)
        users.append(newuser)
        saveToPersistentStore()
        return newuser
    }
    
    func delete (which user: User) -> Bool {
        guard let index = users.firstIndex(of: user) else { return false}
        users.remove(at: index)
        saveToPersistentStore()
        return true
    }
    
    func update (which user: User) -> Bool {
        guard let index = users.firstIndex(of: user) else { return false }
        if let bio = user.bio { users[index].bio = bio }
        if let imageURL = user.imageURL { users[index].imageURL = imageURL }
        if !user.password.isEmpty { users[index].password = user.password }
        if !user.username.isEmpty { users[index].username = user.username }
        
        saveToPersistentStore()
        return true
    }
    
    
    // MARK: - File Persistence Private Methods and Constants
    private let storeContentName: String = "Users"
    private let storeContentFile: String = "users.plist"
    
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
            let data = try encoder.encode(users)
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
            users = try decoder.decode([User].self, from: data)
        } catch {
            print("Error loading \(storeContentName) data: \(error)")
        }
    }
}
