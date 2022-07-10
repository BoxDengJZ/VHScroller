

import Foundation
import UIKit


private struct AssociatedKeys {
    static var AMIsCanScroll = "AMIsCanScroll"
    static var AMOriginOffset = "AMOriginOffset"
}

extension UIScrollView {
    internal var am_isCanScroll: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.AMIsCanScroll) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.AMIsCanScroll, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    internal var am_originOffset: CGPoint? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.AMOriginOffset) as? CGPoint
        }
        set {
            guard am_originOffset == nil else {
                return
            }
            objc_setAssociatedObject(self, &AssociatedKeys.AMOriginOffset, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
