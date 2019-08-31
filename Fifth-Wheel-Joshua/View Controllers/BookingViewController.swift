//
//  BookingViewController.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {
    
    var listing: Listing?
    var datePicker: UIDatePicker?
    var datePicker2: UIDatePicker?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var arrivalTextField: UITextField!
    @IBOutlet weak var departTextField: UITextField!
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var bookingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    private func updateViews () {
        guard let listing = listing else {return}
        if let imageUrl = listing.imageUrl, !imageUrl.isEmpty {
            imageView.downloaded(from: imageUrl)
        } else {
            imageView.image = UIImage(named: "GenericCamping")
        }
        nameLabel.text = listing.name
        descriptionTextView.text = listing.description
        hostLabel.text = listingController.getHostName(from: listing)
        
        //DatePicker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker2 = UIDatePicker()
        datePicker2?.datePickerMode = .date
        let toolbar = UIToolbar()
        let toolbar2 = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        let doneButton2 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker2))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        let cancelButton2 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolbar.sizeToFit()
        toolbar2.sizeToFit()
        toolbar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        toolbar2.setItems([doneButton2, spaceButton, cancelButton2], animated: false)
        
        arrivalTextField.inputAccessoryView = toolbar
        departTextField.inputAccessoryView = toolbar2
        arrivalTextField.inputView = datePicker
        departTextField.inputView = datePicker2
    }
    
    @objc func doneDatePicker() {
        //For date format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        arrivalTextField.text = formatter.string(from: datePicker!.date)
        arrivalTextField.text = formatter.string(from: datePicker!.date)
        self.view.endEditing(true)
    }
    @objc func doneDatePicker2() {
        //For date format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        departTextField.text = formatter.string(from: datePicker2!.date)
        departTextField.text = formatter.string(from: datePicker2!.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

    @IBAction func bookNowTapped(_ sender: Any) {
    navigationController?.topViewController?.navigationItem.hidesBackButton = true
        bookingView.isHidden = false
        bookNowButton.isEnabled = false
        arrivalTextField.becomeFirstResponder()
    }
    
    @IBAction func bookTapped(_ sender: Any) {
        guard let arrivalDate = arrivalTextField.text,
                !arrivalDate.isEmpty,
                let departDate = departTextField.text,
            !departDate.isEmpty
        else {
            alert(vc: self, title: "Error", message: "Please select an arrival and departure date.")
            return
        }
        //TODO: Call add booking
        guard let listing = listing, let userId = userController.loggedInUser?.id else { return }
        
        bookingController.add(listing: listing, userId: userId, startDate: arrivalDate, stopDate: departDate)
        alert(vc: self, title: "Booking", message: "Successfully booked listing.")
        navigationController?.topViewController?.navigationItem.hidesBackButton = false
        bookNowButton.isEnabled = true
        bookingView.isHidden = true
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        navigationController?.topViewController?.navigationItem.hidesBackButton = false
        bookNowButton.isEnabled = true
        bookingView.isHidden = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
