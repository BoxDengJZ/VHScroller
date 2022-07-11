
import UIKit

class AquamanContainView: UIView {
    weak var viewControllerCC: (UIViewController & AquamanChildViewController)?
    var isEmpty: Bool {
        return subviews.isEmpty
    }
    
    func displayingIn(view: UIView, containView: UIView) -> Bool {
        let convertedFrame = containView.convert(frame, to: view)
        return view.frame.intersects(convertedFrame)
    }
}
