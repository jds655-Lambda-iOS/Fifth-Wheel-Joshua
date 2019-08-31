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
    private var userInfo: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else    { return nil }
        return documentsDirectory.appendingPathComponent("fillout.plist")
    }
    private var userDetail: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else    { return nil }
        return documentsDirectory.appendingPathComponent("fillin.plist")
    }
    
    // MARK: - Methods
    init () {
        loadFromPersistentStore()
        loadUsername()
    }
    
    func login (with user: User) -> Bool {
        var result: Bool = false
        for u in users {
            if u.username == user.username {
                if u.password == user.password {
                    self.loggedInUser = u
                    saveUsername()
                    result = true
                }
            }
        }
        return result
    }
    
    private func saveUsername(){
        guard let url = userDetail else {return print("Url not created in directory")}
        do {
            let logginUser = try PropertyListEncoder().encode(loggedInUser)
            try logginUser.write(to: url)
        } catch {
            NSLog("Error saving username data: \(error) ")
        }
    }
    
    private func loadUsername() {
        let fileManager = FileManager.default
        guard let url = userDetail,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedUser = try decoder.decode(User.self, from: data)
            guard let index = users.firstIndex(of: decodedUser) else { return }
            loggedInUser = users[index]
        } catch {
            NSLog("Error loading username data: \(error)")
        }
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
        users[index].landowner = user.landowner ?? false
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
