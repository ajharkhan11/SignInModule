//
//  LoginViewDataSource.swift
//  SignInModule
//
//  Created by Ajharudeen Khan on 03/06/21.
//

import UIKit

class LoginViewDataSource <TEXFIELD: UITextField,T> : NSObject,UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
