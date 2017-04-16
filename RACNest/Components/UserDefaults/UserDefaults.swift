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
