//
//  SignUp.swift
//  Pocket Music
//
//  Created by Hai Duong on 12/5/18.
//  Copyright © 2018 Hai Duong. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class SignUp: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
//    var continueButton:ButtonFormat!
//    var activityView:UIActivityIndicatorView!
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addFadeBackground(top: primary, bottom: secondary)
        
        username.delegate = self
        email.delegate = self
        password.delegate = self
        
        username.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        email.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        password.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //username.becomeFirstResponder()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        usernameField.resignFirstResponder()
//        emailField.resignFirstResponder()
//        passwordField.resignFirstResponder()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @objc func textFieldChanged(_ target:UITextField) {
        let username = self.username.text
        let email = self.email.text
        let password = self.password.text
        let formFilled = username != nil && username != "" && email != nil && email != "" && password != nil && password != ""

    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        
        switch textField {
        case username:
            username.resignFirstResponder()
            email.becomeFirstResponder()
            break
        case email:
            email.resignFirstResponder()
            password.becomeFirstResponder()
            break
        case password:
            signUp(true)
            break
        default:
            break
        }
        return true
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let username = username.text else { return }
        guard let email = email.text else { return }
        guard let pass = password.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed!")
                        self.dismiss(animated: false, completion: nil)
                    } else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
                
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
        
    }

}

