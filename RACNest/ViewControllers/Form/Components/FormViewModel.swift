//
//  FormViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 16/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

struct FormViewModel {
    
    let username: MutableProperty<String>
    let password: MutableProperty<String>

    private let isFormValid: MutableProperty<Bool>

    private(set) lazy var authenticateAction: Action<Void, Void, NoError> = {
        
        return Action<Void, Void, NoError>(enabledIf: self.isFormValid, { _ in
            return SignalProducer { o, d in

                let username = self.username.value ?? ""
                let password = self.password.value ?? ""

                NSUserDefaults.setValue(username, forKey: .Username)
                NSUserDefaults.setValue(password, forKey: .Password)

                o.sendCompleted()
            }
        })
    }()
    
    init(credentialsValidationRule: (String, String) -> Bool = validateCredentials) {
        
        let username = NSUserDefaults.value(forKey: .Username)
        let password = NSUserDefaults.value(forKey: .Password)
        
        self.username = MutableProperty(username)
        self.password = MutableProperty(password)
        
        isFormValid = MutableProperty(credentialsValidationRule(username, password))
        isFormValid <~ combineLatest(self.username.producer, self.password.producer).map(credentialsValidationRule)
    }

}

private func validateCredentials(username: String, password: String) -> Bool {
    
    let usernameRule = username.characters.count > 5
    let passwordRule = password.characters.count > 10
    
    return usernameRule && passwordRule
}
