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

struct SearchViewModel {
    
    let searchText: MutableProperty<String> = MutableProperty("")
    let result: AnyProperty<[String]>
    
    init() {
        
        let dataSourceGenerator = SearchViewModel.generateDataSource()
            .startOn(QueueScheduler(name: "DataSourceQueue"))
        
        let producer = combineLatest(searchText.producer, dataSourceGenerator)
                        .throttle(0.3, onScheduler: QueueScheduler(name: "TextSearchQueue"))
                        .map(SearchViewModel.wordsSubSet)

        result = AnyProperty(initialValue: [], producer: producer)
    }
    
    static private func wordsSubSet(searchTerm: String, words: [String]) -> [String] {
        
        guard  searchTerm != "" else { return words }
        
       return words.filter {
           $0.rangeOfString(searchTerm, options: .CaseInsensitiveSearch) !=  nil
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
