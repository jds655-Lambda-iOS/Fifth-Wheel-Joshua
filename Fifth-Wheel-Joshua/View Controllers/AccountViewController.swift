//
//  AccountViewController.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    // MARK: - Variables/Contants
    var user: User?
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var landownerSwitch: UISwitch!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ListingsView: UIView!
    
    // MARK: - Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if userController.loggedInUser == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = userController.loggedInUser
        tableView.dataSource = self
        tableView.delegate = self
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let user = user else { return }
        if let username = usernameTextField.text, !username.isEmpty {
            user.username = username
        }
        if let password = passwordTextField.text, !password.isEmpty {
            user.password = password
        }
        user.landowner = landownerSwitch.isOn
        if let bio = bioTextView.text, !bio.isEmpty {
            user.bio = bio
        }
        
        if !userController.update(which: user) {
            alert(vc: self, title: "Error", message: "Error updating your account information.")
        } else {
            alert(vc: self, title: "Account Info", message: "Saved Successfully!")
        }
    }
    
    @IBAction func landownerSwitch(_ sender: Any) {
        ListingsView.isHidden = !landownerSwitch.isOn
    }
    
    func updateViews () {
        guard let username = user?.username, let password = user?.password, let landowner = user?.landowner,
            let bio = user?.bio else { return }
        usernameTextField.text = username
        passwordTextField.text = password
        landownerSwitch.isOn = landowner
        bioTextView.text = bio
        ListingsView.isHidden = !landownerSwitch.isOn
        if landownerSwitch.isOn {
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowListingSegue" {
            guard let vc = segue.destination as? ListingDetailViewController else { return }
            if let index = tableView.indexPathForSelectedRow?.item {
                vc.listing = listingController.listings[index]
            }
        }
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        userController.loggedInUser = nil
        performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
}

extension AccountViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingController.userListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListingItem", for: indexPath) as? AccountListingTableViewCell else { return UITableViewCell() }
        cell.listing = listingController.userListings[indexPath.item]
        return cell
    }
}

extension AccountViewController:UITableViewDelegate {
    
}
