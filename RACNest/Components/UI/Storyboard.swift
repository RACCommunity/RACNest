//
//  Storyboard.swift
//  RACNest
//
//  Created by Rui Peres on 16/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

protocol StoryboardSegueType : RawRepresentable { }

extension UIViewController {
    func performSegue<S : StoryboardSegueType where S.RawValue == String>(segue: S, sender: AnyObject? = nil) {
        performSegueWithIdentifier(segue.rawValue, sender: sender)
    }
}