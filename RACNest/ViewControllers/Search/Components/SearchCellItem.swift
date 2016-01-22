//
//  SearchCellItem.swift
//  RACNest
//
//  Created by Rui Peres on 21/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

struct SearchCellItem {
    let title: String
}

extension SearchCellItem: TextPresentable {
    var text: String { return title }
    var textColor: UIColor { return UIColor.grayColor() }
}
