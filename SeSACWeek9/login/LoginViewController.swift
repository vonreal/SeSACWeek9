//
//  LoginViewController.swift
//  SeSACWeek9
//
//  Created by 나지운 on 2022/09/01.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField1: UITextField!
    @IBOutlet weak var userTextField2: UITextField!
    @IBOutlet weak var userTextField3: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.name.bind {
            self.userTextField1.text = $0
        }
        
        viewModel.password.bind {
            self.userTextField2.text = $0
        }

        viewModel.email.bind {
            self.userTextField3.text = $0
        }
        
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .systemYellow : .black
        }
    }
    
    @IBAction func nameTextFieldChanged(_ sender: UITextField) {
        viewModel.name.value = sender.text!
        viewModel.checkValidation()
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        viewModel.password.value = sender.text!
        viewModel.checkValidation()
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        viewModel.email.value = sender.text!
        viewModel.checkValidation()
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        viewModel.signIn {
            print("화면전환")
        }
    }
    
}
