//
//  UserDefaults.swift
//  RACNest
//
//  Created by Rui Peres on 17/01/2016.
//  Copyright © 2016 Rui Peres. All rights reserved.
//

import Foundation

enum UserDefaults: String {
    case Username = "username"
    case Password = "password"
}

extension UserDefaults {
    
    static func value(forKey key: UserDefaults) -> String {
        return Foundation.UserDefaults.standard.object(forKey: key.rawValue) as? String ?? ""
    }
    
    static func setValue(value: String, forKey key: UserDefaults) {
        Foundation.UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}
