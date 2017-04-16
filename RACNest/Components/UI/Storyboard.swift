import UIKit

protocol StoryboardViewControllerType : RawRepresentable { }

extension UIStoryboard {
    
    static func defaultStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func instantiateViewControllerWithIdentifier<S : StoryboardViewControllerType>(identifier: S) -> UIViewController where S.RawValue == String {
        return instantiateViewController(withIdentifier: identifier.rawValue)
    }
}
