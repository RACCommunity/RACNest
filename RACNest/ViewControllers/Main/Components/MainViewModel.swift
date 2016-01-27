//
//  MainViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 13/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

final class MainViewModel: NSObject {
    
    let items: [MainCellItem]
    
    override init() {
        
        let item1 = MainCellItem(title: "1. Form 🐥", identifier: .Form)
        let item2 = MainCellItem(title: "2. Search 🔍", identifier: .Search)
        let item3 = MainCellItem(title: "3. Composition 🚕 🚗 🚙", identifier: .Composition)
        
        items = [item1, item2, item3]

        super.init()
    }
}

extension MainViewModel: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                
        let cell: GenericTableCell = tableView.dequeueReusableCell(indexPath: indexPath)

        cell.configure(items[indexPath.row])

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}


