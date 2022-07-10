

import Foundation
import UIKit

extension UIViewController {
    
    public var amPageViewContoller: AquamanPageViewController? {
        return parent as? AquamanPageViewController
    }
    
    func clearFromParent() {
        willMove(toParent: nil)
        beginAppearanceTransition(false, animated: false)
        view.removeFromSuperview()
        endAppearanceTransition()
        removeFromParent()
    }
}
