//
//  SearchViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 20/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import Foundation
import ReactiveCocoa

enum SearchStatus<T> {
    case Loading
    case Valid([String])
}

class SearchViewModel {
    
    private let dataSource: MutableProperty<SearchStatus<String>> = MutableProperty(.Loading)
    
    init() {
        
        dataSource <~ SearchViewModel.generateDataSource()
            .startOn(QueueScheduler(name: "private_queue"))
            .map { SearchStatus.Valid($0) }
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