
import Foundation
import UIKit

extension NSCache where KeyType == NSString, ObjectType == UIViewController {
    
    subscript(index: Int) -> UIViewController? {
        get {
            return object(forKey: "\(index)" as NSString)
        }
        set {
            guard let newValue = newValue
                , self[index] != newValue else {
                return
            }
            setObject(newValue, forKey: "\(index)" as NSString)
        }
    }
}
