//
//  RacExtensions.swift
//  RACNest
//
//  Created by Rui Peres on 17/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Rex

extension UITextField {

    public var rex_textSignal: SignalProducer<String, NoError> {
        
        return NSNotificationCenter.defaultCenter()
            .rac_notifications(UITextFieldTextDidChangeNotification, object: self)
            .filterMap { notification in
                guard let textField = notification.object as? UITextField else { return nil }
                return textField.text ?? ""
        }
    }
}

extension SignalProducer {
    
    func chain(times: Int, transformation: Value -> SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
        
        var chain = self
        
        (0..<times).forEach { _ in
            chain = chain.flatMap(.Latest, transform: transformation)
        }
        
        return chain
    }
}
