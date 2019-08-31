//
//  ListingsCollectionViewCell.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class ListingsCollectionViewCell: UICollectionViewCell {
    var listing: Listing?{
        didSet{
            updateViews()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private func updateViews () {
        if let imageUrl = listing?.imageUrl, !imageUrl.isEmpty {
            imageView.downloaded(from: imageUrl)
        } else {
            imageView.image = UIImage(named: "GenericCamping")
        }
        let name = listing?.name ?? ""
        let description = listing?.description ?? ""
        nameLabel.text = name
        descriptionLabel.text = description
    }
}
