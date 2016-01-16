//
//  MainViewTableCellItem.swift
//  RACNest
//
//  Created by Rui Peres on 13/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

struct MainViewTableCellItem {
    
    let title: String
    let identifier: StoryboardSegue
}

extension MainViewTableCellItem: TextPresentable {
    
    var text: String { return title }
    var textColor: UIColor { return .darkGrayColor() }
}

extension MainViewTableCellItem: ViewControllerStoryboardIdentifier { }