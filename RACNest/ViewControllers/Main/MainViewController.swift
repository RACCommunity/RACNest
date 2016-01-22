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
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(GenericTableCell)
        
        tableView.dataSource = viewModel
        tableView.delegate = self
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let item = viewModel.items[indexPath.row]
        
        let viewController = UIStoryboard.defaultStoryboard().instantiateViewControllerWithIdentifier(item.identifier)
        
        viewController.title = item.title
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

