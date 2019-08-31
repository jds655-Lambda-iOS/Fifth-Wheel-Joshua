//
//  Helpers.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation
import UIKit

func alert (vc: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    vc.present(alert, animated: true)
}
