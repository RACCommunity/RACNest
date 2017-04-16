import UIKit

struct MainCellItem {
    
    let title: String
    let identifier: StoryboardViewController
}

extension MainCellItem: TextPresentable {
    
    var text: NSAttributedString {
        return NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName: UIColor.darkGray])
    }
}

extension MainCellItem: ViewControllerStoryboardIdentifier { }
