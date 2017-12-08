//
//  SecondViewController.swift
//  ReactivePractice
//
//  Created by Marcel Chaucer on 12/4/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var buttonIsEnabledButton: UIButton!
    
    var viewModel: SecondViewControllerViewModel!
    
    var contentChangeObserver: Signal<Void, NoError>.Observer!
    
    override func viewDidLoad() {
        viewModel = SecondViewControllerViewModel()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        super.viewDidLoad()
        bindings()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         print("""
                firstName: \(viewModel.firstNameTextFieldText.value ?? ""),
                lastName: \(viewModel.lastNameTextFieldText.value ?? ""),
                phoneNumber: \(viewModel.phoneNumberTextFieldText.value ?? ""),
                email: \(viewModel.emailTextFieldText.value ?? ""),
                textFieldText: \(String(describing: textField.text ?? ""))
                isEnabled: \(viewModel.isEnabled.value)
               """)
        return true
    }
    
    func bindings() {
        viewModel.firstNameTextFieldText <~ firstNameTextField.reactive.continuousTextValues
        viewModel.lastNameTextFieldText <~ lastNameTextField.reactive.continuousTextValues
        viewModel.phoneNumberTextFieldText <~ phoneNumberTextField.reactive.continuousTextValues
        viewModel.emailTextFieldText <~ emailTextField.reactive.continuousTextValues
        buttonIsEnabledButton.reactive.isEnabled <~ viewModel.isEnabled
    }
}

