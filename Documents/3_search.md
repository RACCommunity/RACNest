#### 3. Search 🔍

For a begginner in the FRP paradigm, throttling is a foreign concept. A quick way  to understand it in the real world is via a search. Let's imagine that you are searching something and everytime you tap the keyboard a new server is initiated. This can be quite expensive and complex to implement. So:

1. Character "A" is inputted. 
2. New server call starts.
3. Character "B" is inputted.
4. Cancel the current on going server call and initiate a new one

The problem with this approach is that it doesn't take into account the frequency at which a new letter is inputted. Not only that, it's a waste of resources.

Throtlling solves this problem by creating an interval between each input. Imagine that the user is inputting a new letter every 0.1s. If we set throttling with an interval of 0.5s, only at the 5th letter the search will commence. This makes more sense than going back and forth with new requests and cancelling the previous one. 

----

In our example (that can be found [here](https://github.com/RuiAAPeres/RACNest/tree/master/RACNest/ViewControllers/Search)), we make use of the `throttle` operator to achieve what was described above. Let's start with the `SearchViewController`:

```
viewModel.result.producer.observeOn(QueueScheduler.mainQueueScheduler).startWithNext {[weak self] _ in
    self?.tableView.reloadData()
}
```

In this case we are just reloading the `UITableView` everytime a new set of results comes. As a side note, [RxSwift provides](https://github.com/ReactiveX/RxSwift/blob/b00d35a5ef13dbcf57257f47fb14a60a2c924d19/RxCocoa/iOS/UITableView%2BRx.swift) a more integrate approach to this kind of problems. 

In the second bit, we are setting the new search term:

```
func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.searchText.value = searchText
}
```

Let's now have a look at the `SearchViewModel`, more specically to how we are building the [data source](https://github.com/RuiAAPeres/RACNest/blob/master/RACNest/ViewControllers/Search/DataSource/words.txt):

```
    static private func generateDataSource() -> SignalProducer<[String], NoError> {
        
        return SignalProducer {observable, disposable in
            
            let path: String = NSBundle.mainBundle().pathForResource("words", ofType: "txt")!       // 1
            let string: String = try! String(contentsOfFile: path, encoding: NSUTF8StringEncoding)  // 2
            let words = string.characters.split("\n").map(String.init)                              // 3
            
            observable.sendNext(words)                     
            observable.sendCompleted()
        }
    }
```

The weird part is how a `SignalProducer` is created, the rest is pretty standard:

1. Get the path to the `words.txt file
2. Create a single string with all of them
3. Split them into an array of words

So the `SignalProducer` has you have guessed, is a struct that takes a closure to be initialized. The closure itself is of type `(Signal<Value, Error>.Observer, CompositeDisposable) -> ())`. So what the hell does this means to you?
