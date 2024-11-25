//
//  SignUpViewController.swift
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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "SignUp"
        passwordTextField.isSelected = false
        passwordTextField.isSecureTextEntry = true
        setUpToolBar()
        phoneNumberTextField.keyboardType = .decimalPad
        pickImageButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
    }
    ///email validation regex i found on internet
    ///
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    ///
    ///checking value
    ///
    func isInputtedEmailValid()->Bool{
        let email = emailTextField.text ?? ""
        return isValidEmail(email)
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
        if !isInputtedEmailValid(){
            presentAlert(title: "input actual email", message: "in the email field please input a valid email")
        }
        if !passwordContainsUppercase(){
            presentAlert(title: "password issue!", message: "password must contain an uppercase letter")
        }
        navigateToHomeViewController()
    }
    ///  this function creates homeViewController instance  or instantiates the view controller, idk. vkmni sheyvanili fieldebidan users da vawvdi users shekmnil instancirebul homeviews. push view, present.
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
            //navigationController?.pushViewController(homeVC, animated: true)
            homeVC.modalPresentationStyle = .fullScreen
            present(homeVC, animated: true , completion: nil)
        }
    }
    /// this function changes passwords border color whenever called, based on its validity
    @IBAction func didEnterPassword(_ sender: UITextField) {
        passwordTextField.layer.borderWidth = 3
        let passwordValid = [passwordContainsUppercase(), isPasswordValid()].contains(false)
        passwordTextField.layer.borderColor = !passwordValid ? UIColor.green.cgColor : UIColor.red.cgColor
    }
    @IBAction func didEnterEmail(_ sender: UITextField) {
        emailTextField.layer.borderWidth = 3
        emailTextField.layer.borderColor = isInputtedEmailValid() ? UIColor.green.cgColor : UIColor.red.cgColor
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
    func passwordContainsUppercase() -> Bool{
        let inputPassword = passwordTextField.text ?? ""
        return inputPassword.contains(where: { $0.isUppercase })
    }
}





