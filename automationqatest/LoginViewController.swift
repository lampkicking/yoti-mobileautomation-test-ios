//
//  LoginViewController.swift
//  Automation QA Test
//
//  Created by Casper Lee on 22/05/2019.
//  Copyright © 2019 Yoti Limited. All rights reserved.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let dummyCredentials = ["username@yoti.com":"longpassword", "login@yoti.com":"verystrongpassword"]
    
    private enum SegueIdentifier: CodingKey {
        case login
    }
    
    private var email: String? {
        return emailTextField.text
    }
    
    private var password: String? {
        return passwordTextField.text
    }
    
    private func sanitisedInput() -> (email: String, password: String)? {
        guard let email = email else {
            emailTextField.invalidate(withMessage: "This field is required")
            return nil
        }
        
        guard isValidEmail(email) else {
            emailTextField.invalidate(withMessage: "This email address is invalid")
            return nil
        }
        
        guard let password = password, isValidPassword(password) else {
            present(errorMessage: "The password is too short")
            return nil
        }
        
        return (email, password)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        return email.contains("@")
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        return password.count > 4
    }
    
    private func attemptLogin(with email: String, password: String) -> Bool {
        let isValid = dummyCredentials.contains { $0.key == email && $0.value == password}
        guard isValid else {
            if dummyCredentials.keys.contains(email) {
                present(errorMessage: "This password is incorrect")
            } else {
                present(errorMessage: "This email address is invalid")
            }
            return false
        }
        return true
    }
    
    private func present(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.resetState()
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func resetState() {
        emailTextField.text = nil
        passwordTextField.text = nil
        emailTextField.resetPlaceHolder(withMessage: "Email")
    }
    
    @IBAction func unwind(segue:UIStoryboardSegue) {
        resetState()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case SegueIdentifier.login.stringValue:
            guard let userInput = sanitisedInput() else {
                return false
            }
            return attemptLogin(with: userInput.email, password: userInput.password)
        default:
            return false
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case emailTextField:
            textField.resetPlaceHolder(withMessage: "Email")
        default: break
        }
        return true
    }
}

extension UITextField {
    func invalidate(withMessage message: String = "") {
        text = nil
        attributedPlaceholder = NSAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        becomeFirstResponder()
    }
    
    func resetPlaceHolder(withMessage message: String = "") {
        attributedPlaceholder = NSAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
}

