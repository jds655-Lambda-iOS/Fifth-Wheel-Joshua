//
//  LoginViewController.swift
//  Fifth-Wheel-Joshua
//
//  Created by Joshua Sharp on 8/30/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginRegSegmented: UISegmentedControl!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var landownerStackView: UIStackView!
    @IBOutlet weak var landownerSwitch: UISwitch!
    
    var doLogin: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goButton.setTitle("Login", for: .normal)
        landownerStackView.isHidden = true
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginRegTapped(_ sender: Any) {
        switch loginRegSegmented.selectedSegmentIndex {
        case 0:
            goButton.setTitle("Login", for: .normal)
            landownerStackView.isHidden = true
            doLogin = true
        case 1:
            goButton.setTitle("Register", for: .normal)
            landownerStackView.isHidden = false
            doLogin = false
        default:
            break
        }
    }
    
    @IBAction func goButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text,
            !username.isEmpty, !password.isEmpty
            else {
                alert(vc: self, title: "Error", message: "Please enter both username and password")
                return
            }
        let user = User(username: username, password: password, landowner: landownerSwitch.isOn)
        if doLogin {
            if userController.login(with: user) {
                //alert(vc: self, title: "Login", message: "Login Succeeded!")
                //TODO: Segue to last VC
//                DispatchQueue.main.async {
//                    self.dismiss(animated: true, completion: nil)
//                }
                performSegue(withIdentifier: "TabBarSegue", sender: self)
            } else {
                alert(vc: self, title: "Login", message: "Login failed, please try again.")
            }
        } else {
            if userController.register(with: user) {
                alert(vc: self, title: "Registration", message: "You will now be taken to the account info screen to fill out your information.")
                performSegue(withIdentifier: "AccountSegue", sender: self)
            } else {
                alert(vc: self, title: "Registration", message: "Registration failed, please try again.")
            }
        }
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
