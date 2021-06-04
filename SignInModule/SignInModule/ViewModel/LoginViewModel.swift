//
//  LoginViewModel.swift
//  SignInModule
//
//  Created by Ajharudeen Khan on 02/06/21.
//

import Foundation
import UIKit

enum CredentialStatus {
    case Sucess
    case EmptyUserName
    case EmptyPassword
    case EmptyPasswordAndUserName
    case InvalidUserName
    case InvalidPassword
}

class LoginViewModel : NSObject{
    
    private var userNameRegex : String
    
    private var passwordRegex : String
    
    var bindLoginViewModelToController :((_ status:CredentialStatus)->()) = {_ in }
    
    var credential = Credential(){
        didSet{
            //handle credential update
            let status = checkCredential()
            self.bindLoginViewModelToController(status)
        }
    }
    
    init(userNameRegex:String , passwordRegex: String) {
        self.userNameRegex = userNameRegex
        self.passwordRegex = passwordRegex
        super.init()
    }
    
    override init() {
        self.userNameRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        self.passwordRegex = #"(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
        super.init()
    }
    
    func checkCredential() -> CredentialStatus {
        if credential.username.isEmpty &&  credential.password.isEmpty{
            return .EmptyPasswordAndUserName
        }
        
        if credential.username.isEmpty{
            return .EmptyUserName
        }
        
        if credential.password.isEmpty {
            return .EmptyPassword
        }
        
        if !isValidUserName(userName: credential.username) {
            return .InvalidUserName
        }
        
        if !isValidPassword(password: credential.password) {
            return .InvalidPassword
        }
        return .Sucess
    }
    
    func isValidUserName(userName: String) -> Bool {
        let testEmail = NSPredicate(format:"SELF MATCHES %@", userNameRegex)
        return testEmail.evaluate(with: userName)
    }
    
    func isValidPassword(password: String) -> Bool {
        let testEmail = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return testEmail.evaluate(with: password)
    }
}

