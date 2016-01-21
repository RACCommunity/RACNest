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
    
    let dataSource: MutableProperty<[String]> = MutableProperty([])
    
    init() {
        
        dataSource <~ SearchViewModel.generateDataSource().startOn(QueueScheduler(name: "private_queue"))
    }
    
    static private func generateDataSource() -> SignalProducer<[String], NoError> {
    
        return SignalProducer {o, d in
            
            let path: String = NSBundle.mainBundle().pathForResource("words", ofType: "txt")!
            let string: String = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            o.sendNext(string.characters.split("\n").map(String.init))
            o.sendCompleted()
        }
    }
}