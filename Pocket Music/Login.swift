//
//  Login.swift
//  Pocket Music
//
//  Created by Hai Duong on 12/5/18.
//  Copyright © 2018 Hai Duong. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class Login: UIViewController, UITextFieldDelegate {

  
    @IBOutlet weak var emailLog: UITextField!
    @IBOutlet weak var passwordLog: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addFadeBackground(top: primary, bottom: secondary)

        
        emailLog.delegate = self
        passwordLog.delegate = self
        
        emailLog.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordLog.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailLog.becomeFirstResponder()

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailLog.resignFirstResponder()
        passwordLog.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    @objc func textFieldChanged(_ target: UITextField) {
        let email = emailLog.text
        let password = passwordLog.text
        _ = email != nil && email != "" && password != nil && password != ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailLog:
            emailLog.resignFirstResponder()
            passwordLog.becomeFirstResponder()
            break
        case passwordLog:
            signIn(true)
            break
        default:
            break
        }
        return true
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        guard let email = emailLog.text else {return}
        guard let password = passwordLog.text else {return}
        

        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
            } else {
                let popUpAlert = UIAlertController(title: "Invalid Email or Password", message: "Please check and re-enter email or password and try again!", preferredStyle: .alert)
                popUpAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: {(action) in popUpAlert.dismiss(animated: true, completion: nil)}))
                self.present(popUpAlert, animated: true, completion: nil)
            }
        }
    }
    
}
