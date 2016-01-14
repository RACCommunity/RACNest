//
//  MainViewController.swift
//  RACNest
//
//  Created by Rui Peres on 13/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = mainViewModel
        tableView.delegate = self
        tableView.registerReusableCell(MainViewTableCell)
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let item = mainViewModel.items[indexPath.row]
        self.performSegueWithIdentifier(item.identifier, sender: nil)
    }
}

