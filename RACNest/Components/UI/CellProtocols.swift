import UIKit

// Taken from here https://www.natashatherobot.com/updated-protocol-oriented-mvvm-in-swift-2-0/
// Great stuff from https://twitter.com/NatashaTheRobot

protocol TextPresentable {
    
    var text: NSAttributedString { get }
}

protocol ViewControllerStoryboardIdentifier {
    
    var identifier: StoryboardViewController { get }
}
