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
import Result

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