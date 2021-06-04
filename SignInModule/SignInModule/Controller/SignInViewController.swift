//
//  ViewController.swift
//  SignInModule
//
//  Created by Ajharudeen Khan on 31/05/21.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    private var loginViewModel : LoginViewModel!
    
    private var loginTextFieldDataSource : LoginViewDataSource<UITextField,Credential>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signInBtn.isEnabled = false
        callToViewModelForUIUpdate()
        
    }
    
    func callToViewModelForUIUpdate() {
        loginViewModel  = LoginViewModel.init()
        loginViewModel.bindLoginViewModelToController = { [unowned self] status in
            switch status {
            case .Sucess:
                signInBtn.isHidden = true
            case .EmptyUserName:
                showAlert(message: "Please enter email first")
            case .EmptyPassword:
                showAlert(message: "Please enter password first")
            case .InvalidUserName:
                showAlert(message: "Please enter valid email")
            case .InvalidPassword:
                showAlert(message: "Please enter valid password")
            case .EmptyPasswordAndUserName:
                showAlert(message: "Please enter email and password first")
            }
        }
    }
    
    func updateDataSource() {
        self.loginTextFieldDataSource = LoginViewDataSource.init()
    }
    
    @IBAction func onClickSignIn(_ sender: UIButton) {
        //Sign In
    }
    
    @IBAction func onClickSignUp(_ sender: UIButton) {
        // Sign Up
    }
    
    func showAlert(message: String) {
        let controller = UIAlertController.init(title: "Error!!!", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
            controller.dismiss(animated: true, completion: nil)
        }))
        
        present(controller, animated: true, completion: nil)
    }
}

extension SignInViewController : UITextFieldDelegate{
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            loginViewModel.credential.username =  textField.text ?? ""
        }
        
        if textField == passwordTextField {
            textField.resignFirstResponder()
            loginViewModel.credential.password = textField.text ?? ""
        }
        return true
    }
}

