//
//  TableViewProtocols.swift
//  RACNest
//
//  Created by Rui Peres on 13/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import Foundation
import UIKit

// Taken from here https://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/
// Great stuff from https://twitter.com/aligatr

protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(Self) }
    static var nib: UINib? { return nil }
}

extension UITableView {
    
    func registerReusableCell<T: UITableViewCell where T: Reusable>(_: T.Type) {
        if let nib = T.nib {
            self.registerNib(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.registerClass(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell where T: Reusable>(indexPath indexPath: NSIndexPath) -> T {
        return self.dequeueReusableCellWithIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as! T
    }
}
