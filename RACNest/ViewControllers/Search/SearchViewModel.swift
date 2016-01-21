//
//  SearchViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 20/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import Foundation
import ReactiveCocoa

class SearchViewModel {
    
    private let dataSource: [String]
    
    init() {
        
        let path: String = NSBundle.mainBundle().pathForResource("words", ofType: "txt")!
        let string: String = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)

        dataSource = string.characters.split("\n").map(String.init)
    }
}