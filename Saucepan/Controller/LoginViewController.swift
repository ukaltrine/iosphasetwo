//
//  LoginViewController.swift
//  Saucepan
//
//  Created by Kaltrina UKA on 3/12/19.
//  Copyright © 2019 Kaltrina UKA. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signInButton(_ sender: Any) {
        authentication()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()

    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: __________________________________________________Authntication
    func authentication(){
        
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (user,error) in
            
            SVProgressHUD.show()
            
            if error != nil {
                let msg = "Wrong email or password!"
                self.setupAlert(msg)
                SVProgressHUD.dismiss()
            } else {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToHome", sender: self)
            }
            
        }
    }
    
    
    //MARK: __________________________________________________Delegates
    func setDelegates(){
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        signInButton.layer.cornerRadius = 5.0
    }
    
    
    //MARK: __________________________________________________Alert Function
    func setupAlert(_ error: String){
        
        let alertViewController = UIAlertController(title: "Error Message", message: error, preferredStyle: .actionSheet)
        
        alertViewController.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { (_) in

            self.usernameTextField.text = "uka@mail.com"
            self.passwordTextField.text = "123456"

        } ))
        
        self.present(alertViewController, animated: true)
        
    }
    
    
}
