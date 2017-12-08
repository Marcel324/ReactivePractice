//
//  SecondViewControllerViewModel.swift
//  ReactivePractice
//
//  Created by Marcel Chaucer on 12/7/17.
//  Copyright © 2017 Marcel Chaucer. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result
import ReactiveCocoa

class SecondViewControllerViewModel: NSObject {
    
    var firstNameTextFieldText = MutableProperty<String?>("")
    var lastNameTextFieldText = MutableProperty<String?>("")
    var phoneNumberTextFieldText = MutableProperty<String?>("")
    var emailTextFieldText = MutableProperty<String?>("")
    var isEnabled = MutableProperty<Bool>(false)

    
    override init() {
        super.init()
        buttonEnabled()
    }
    
    func buttonEnabled() {
        self.isEnabled <~
            SignalProducer.combineLatest(self.firstNameTextFieldText, self.lastNameTextFieldText, self.phoneNumberTextFieldText, self.emailTextFieldText).map { (firstName, lastName, phoneNumber, email) in
                return !firstName!.isEmpty && !lastName!.isEmpty && !phoneNumber!.isEmpty && !email!.isEmpty
        }
    }
}
