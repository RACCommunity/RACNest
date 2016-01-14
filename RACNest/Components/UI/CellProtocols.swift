//
//  CellProtocols.swift
//  RACNest
//
//  Created by Rui Peres on 13/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

// Taken from here https://www.natashatherobot.com/updated-protocol-oriented-mvvm-in-swift-2-0/
// Great stuff from https://twitter.com/NatashaTheRobot

protocol TextPresentable {
    
    var text: String { get }
    var textColor: UIColor { get }
}

protocol ViewControllerStoryboardIdentifier {
    
    var identifier: String { get }
}