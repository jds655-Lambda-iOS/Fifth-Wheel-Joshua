//
//  ListingDetailViewController.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ListingDetailViewController: UIViewController {

    var listing: Listing?{
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var imageUrlTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: UIBarButtonItem) {
        switch sender.action {
        default:
            break
        }
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
