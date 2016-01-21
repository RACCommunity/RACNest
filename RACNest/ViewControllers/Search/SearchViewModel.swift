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

class SearchViewModel {
    
    let searchText: MutableProperty<String> = MutableProperty("")
    let result: MutableProperty<SearchStatus<String>> = MutableProperty(.Loading)
    
    private let dataSource: MutableProperty<[String]> = MutableProperty([])
    
    init() {
        
        let dataSourceGenerator = SearchViewModel.generateDataSource()
            .startOn(QueueScheduler(name: "GenerateDataSource"))
        
        let dataSourceGeneratorTrigger: SignalProducer<Void, NoError> = dataSourceGenerator.map{_ in () }.ignoreError()
        
        dataSource <~ dataSourceGenerator

        let producer = searchText.producer
        
        result <~ producer.map {_ in .Loading }
        result <~ producer
            .skipUntil(dataSourceGeneratorTrigger)
            .throttle(0.3, onScheduler: QueueScheduler(name: "TextThrottle"))
            .map(wordsSubSet)
            .map { .Valid($0) }
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
