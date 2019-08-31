//
//  ListingDetailViewController.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ListingDetailViewController: UIViewController {

    var listing: Listing?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setToolbarHidden(false, animated: true)
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        var newListing: Listing
        guard let name = nameTextField.text, !name.isEmpty,
                let description = descriptionTextView.text, !description.isEmpty else {
                    alert(vc: self, title: "Error", message: "Please enter text for both the name and description.")
                    return
        }
        let address = addressTextField.text ?? ""
        let imageUrl = imageUrlTextField.text ?? ""
        if let userId = userController.loggedInUser?.id {
            if listing == nil {
                newListing = Listing(userId: userId, name: name, description: description, imageUrl: imageUrl, address: address)
                if listingController.add(listing:  newListing) != nil {
                    alert(vc: self, title: "Listing", message: "Adding listing succeeded.")
                } else {
                    alert(vc: self, title: "Listing", message: "Adding listing failed.")
                }
            } else {
                if let newListing = listing {
                    newListing.name = name; newListing.description = description;
                    newListing.imageUrl = imageUrl; newListing.address = address
                    if listingController.update(which: newListing) {
                        alert(vc: self, title: "Listing", message: "Updating listing succeeded.")
                    } else {
                        alert(vc: self, title: "Listing", message: "Updating listing failed.")
                    }
                }
            }
        } else {
            alert(vc: self, title: "Error", message: "You must be logged in to add listings.")
        }
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func updateViews() {
        nameTextField.text = listing?.name ?? ""
        descriptionTextView.text = listing?.description ?? ""
        addressTextField.text = listing?.address ?? ""
        imageUrlTextField.text = listing?.imageUrl ?? ""
        if let imageUrl = listing?.imageUrl {
            imageView.downloaded(from: imageUrl)
        } else {
            imageView.image = UIImage(named: "GenericCamping")
        }
    }
    
}
