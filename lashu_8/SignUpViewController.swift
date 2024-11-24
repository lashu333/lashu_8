//
//  ViewController.swift
//  lashu_8
//
//  Created by Lasha Tavberidze on 24.11.24.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    let toolBar = UIToolbar()
    var canRegister: Bool = false
    let alert1 = UIAlertController(title: "Nuh-uh!", message: "Fill the fields!", preferredStyle: .alert)
    let alert2 = UIAlertController(title: "password too short,it should be at least 8 symbols!", message: "enter a bigger password!", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        setUpToolBar()
        alert1.addAction(UIAlertAction(title: "OK", style: .default))
        alert2.addAction(UIAlertAction(title: "OK", style: .default))
        
    }
    private func setUpToolBar(){
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [doneButton]
        [usernameTextField, emailTextField, passwordTextField, phoneNumberTextField].forEach {
            $0?.inputAccessoryView = toolBar
        }
    }
    @objc func doneButtonTapped(){
        view.endEditing(true)
    }
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        print("🔵 Button tapped")
        print("🔵 Empty fields: \(hasEmptyFields())")
        print("🔵 Password valid: \(passwordValidation())")
        
        if hasEmptyFields() {
            print("❌ Empty fields detected")
            canRegister = false
            self.present(alert1, animated: true)
            return
        }
        
        if !passwordValidation() {
            print("❌ Password validation failed")
            canRegister = false
            self.present(alert2, animated: true)
            return
        }
        
        print("✅ Attempting to navigate to HomeViewController")
        if let homeVC = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController {
            print("✅ Successfully created HomeViewController")
            let username = usernameTextField.text ?? ""
            let email = emailTextField.text ?? ""
            let phoneNumber = phoneNumberTextField.text ?? ""
            let user = Person(username: username, email: email, password: phoneNumber, phoneNumber: phoneNumber)
            homeVC.user = user
            if let navController = self.navigationController {
                print("✅ Navigation controller exists")
                navController.pushViewController(homeVC, animated: true)
            } else {
                print("❌ No navigation controller found")
            }
        } else {
            print("❌ Could not create HomeViewController")
        }
    }
    @IBAction func didEnterPassword(_ sender: UITextField) {
        if passwordValidation(){
            passwordTextField.layer.borderColor = UIColor.green.cgColor
        }else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    private func passwordValidation() -> Bool {
        if let password = passwordTextField.text {
            if password.count < 8 {
                
                return false
                
            } else {
                return true
            }
            
        }
        return false
    }
    func hasEmptyFields() -> Bool {
        return [usernameTextField, emailTextField, passwordTextField, phoneNumberTextField].contains { $0?.text?.isEmpty ?? true }
    }
}





