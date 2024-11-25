//
//  ViewController.swift
//  lashu_8
//
//  Created by Lasha Tavberidze on 24.11.24.
//

import UIKit
import PhotosUI
class SignUpViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate, PHPickerViewControllerDelegate {
    /// img picker protocol
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

               guard let result = results.first else { return }
               if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                   result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                       guard let self = self, let selectedImage = image as? UIImage else { return }
                       DispatchQueue.main.async {
                           self.imageView.image = selectedImage
                       }
                   }
               }
    }
    /// imported UI stuff
    @IBOutlet weak var pickImageButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let toolBar = UIToolbar()
    /// toolBar for done and next buttons, nextis dawera mezareba
    ///
    let alert1 = UIAlertController(title: "Nuh-uh!", message: "Fill the fields!", preferredStyle: .alert)
    let alert2 = UIAlertController(title: "password too short,it should be at least 8 symbols!", message: "enter a bigger password!",
                                preferredStyle: .alert)
    /// created alerts, on which i will append action "ok" later on, since they can't be closed
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSelected = false
        passwordTextField.isSecureTextEntry = true
        setUpToolBar()
        alert1.addAction(UIAlertAction(title: "OK", style: .default))
        alert2.addAction(UIAlertAction(title: "OK", style: .default))
        
                
            
               pickImageButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
    }
    
    /// toolBar function ,which adds done button to created UIToolBar instance
    private func setUpToolBar(){
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [doneButton]
        [usernameTextField, emailTextField, passwordTextField, phoneNumberTextField].forEach {
            $0?.inputAccessoryView = toolBar
        }
    }
    /// view.endEditing(true) chaxuravs keyboards
    @objc func doneButtonTapped(){
        view.endEditing(true)
    }
    /// am funqciashi vqmni pickers delegate ra aris ver vigeb
    @objc func pickImage(){
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
        
    }
    /// when tapping register button if fields arent empty and password is longer than 8 symbols, we can navigate to home view controller, or sign up
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
            if hasEmptyFields() {
                presentAlert(title: "Nuh-uh!", message: "Fill the fields!")
                return
            }

            if !isPasswordValid() {
                presentAlert(title: "Password too short", message: "It should be at least 8 symbols!")
                return
            }

            navigateToHomeViewController()
        }
    ///  this function creates homeViewController instance  or instantiates the view controller, idk. vkmni sheyvanili fieldebidan users da vawvdi users shekknil instancirebul homeviews. push view
    private func navigateToHomeViewController() {
           if let homeVC = storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController {
               let user = Person(
                   username: usernameTextField.text ?? "",
                   email: emailTextField.text ?? "",
                   password: passwordTextField.text ?? "",
                   phoneNumber: phoneNumberTextField.text ?? "",
                   image: imageView?.image
               )
               homeVC.user = user
               navigationController?.pushViewController(homeVC, animated: true)
           }
       }
    /// this function changes passwords border color whenever called, based on its validity
    @IBAction func didEnterPassword(_ sender: UITextField) {
        passwordTextField.layer.borderWidth = 3
            passwordTextField.layer.borderColor = isPasswordValid() ? UIColor.green.cgColor : UIColor.red.cgColor
        }
    /// since there are 2 alerts, rom ar gameordes kodi amitoa es funkcia
    private func presentAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    /// guardit unwraps vuketebt parolis text fields da tu nil ar iyo vtvlit da 8ze naklebi simbolo tu ak falses daabrunebs es funkcia
    private func isPasswordValid() -> Bool {
           guard let password = passwordTextField.text else { return false }
           return password.count >= 8
       }
    /// empty ar unda iyos
    func hasEmptyFields() -> Bool {
        return [usernameTextField, emailTextField, passwordTextField, phoneNumberTextField].contains { $0?.text?.isEmpty ?? true }
    }
}





