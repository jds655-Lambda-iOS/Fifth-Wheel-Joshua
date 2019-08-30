//
//  AccountViewController.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if userController.loggedInUser == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
