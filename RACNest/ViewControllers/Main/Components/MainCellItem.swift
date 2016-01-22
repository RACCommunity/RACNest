//
//  MainCellItem.swift
//  RACNest
//
//  Created by Rui Peres on 13/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

struct MainCellItem {
    
    let title: String
    let identifier: StoryboardViewController
}

extension MainCellItem: TextPresentable {
    
    var text: String { return title }
    var textColor: UIColor { return .darkGrayColor() }
}

extension MainCellItem: ViewControllerStoryboardIdentifier { }