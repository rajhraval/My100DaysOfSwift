//
//  ViewController.swift
//  Project28
//
//  Created by RAJ RAVAL on 21/10/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController, PasswordManagerDelegate {
    
    @IBOutlet var secret: UITextView!
    var passwordManager: PasswordManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Nothing to see here"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
        
        passwordManager = PasswordManager(controller: self)
        passwordManager.delegate = self
        if !passwordManager.isPasswordCreated() {
            passwordManager.createPassword()
        }
        
    }

    @IBAction func authenticateTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        guard let error = authenticationError as? LAError else { return }
                        
                        switch error.code {
                        case .userFallback:
                            self?.passwordManager.requirePassword()
                        default:
                            let ac = UIAlertController(title: "Authenctication Failed", message: "You could not be verified.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self?.present(ac, animated: true)
                        }
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Biometry Unavailable", message: "Your device cannot be configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardvalue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardScreenEnd = keyboardvalue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    func unlockSecretMessage() {
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveSecretMessage))
        navigationItem.rightBarButtonItem = done
        
        secret.isHidden = false
        title = "Secret Stuff"
        
        secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        
        title = "Nothing to see here"
        
        navigationItem.rightBarButtonItem = nil
    }
    
    func newPasswordCreationSuccessful() {
        print("Password Creation Successful")
    }
    
    func passwordAuthenticated() {
        print("Password authenticated")
        unlockSecretMessage()
    }
    
    
}

