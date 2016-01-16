//
//  MainViewModel.swift
//  RACNest
//
//  Created by Rui Peres on 13/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

class MainViewModel: NSObject {
    
    let items: [MainViewTableCellItem]
    
    override init() {
        
        let item1 = MainViewTableCellItem(title: "Form 🐥", identifier: .Form)
        items = [item1]

        super.init()
    }
}

extension MainViewModel: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                
        let cell: MainViewTableCell = tableView.dequeueReusableCell(indexPath: indexPath)

        cell.configure(items[indexPath.row])

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}


