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
    
    let result: MutableProperty<SearchStatus<String>> = MutableProperty(.Loading)
    
    private let dataSource: MutableProperty<[String]> = MutableProperty([])
    
    init() {
        
        dataSource <~ SearchViewModel.generateDataSource()
            .startOn(QueueScheduler(name: "private_queue"))
        
        result <~ SignalProducer(value: dataSource.value).map { SearchStatus.Valid($0) }
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
