//
//  SearchViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 20/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Rex

enum SearchStatus<T> {
    case Loading
    case Valid([String])
}

struct SearchViewModel {
    
    let searchText: MutableProperty<String> = MutableProperty("")
    let result: MutableProperty<[String]> = MutableProperty([])

    private let dataSource: MutableProperty<[String]> = MutableProperty([])
    
    init() {
        
        let dataSourceGenerator = SearchViewModel.generateDataSource()
            .startOn(QueueScheduler(name: "DataSourceQueue"))
        
        dataSource <~ dataSourceGenerator

        let producer = searchText.producer
        let dataSourceIsReady = dataSource.producer.filter { $0.count > 0 }

        result <~ dataSourceIsReady.take(1)
        result <~ producer
            .skipUntil(dataSourceIsReady.map { _ in})
            .throttle(0.3, onScheduler: QueueScheduler(name: "TextSearchQueue"))
            .map(wordsSubSet)
    }
    
    private func wordsSubSet(word: String) -> [String] {
        
        guard  word != "" else { return dataSource.value }
        
       return dataSource.value.filter {
           $0.rangeOfString(word, options: .CaseInsensitiveSearch) !=  nil
        }
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
