
import Foundation
import UIKit

protocol AMPageControllerDataSource: AnyObject {
    
    func pageController(_ pageController: AquamanPageViewController, viewControllerAt index: Int) -> (UIViewController & AquamanChildViewController)
    func numberOfViewControllers(in pageController: AquamanPageViewController) -> Int
    func headerViewFor(_ pageController: AquamanPageViewController) -> UIView
    
    
    
    func headerViewHeightFor(_ pageController: AquamanPageViewController) -> CGFloat
    func menuViewFor(_ pageController: AquamanPageViewController) -> UIView
    func menuViewHeightFor(_ pageController: AquamanPageViewController) -> CGFloat
    
    
    
    func menuViewPinHeightFor(_ pageController: AquamanPageViewController) -> CGFloat
    
    
    
    /// The index of the controller displayed by default. You should have menview ready before setting this value
    ///
    /// - Parameter pageController: AquamanPageViewController
    /// - Returns: Int
    func originIndexFor(_ pageController: AquamanPageViewController) -> Int
}

protocol AMPageControllerDelegate: AnyObject {
    /// Any offset changes in pageController's contentScrollView
    ///
    /// - Parameters:
    ///   - pageController: AquamanPageViewController
    ///   - scrollView: contentScrollView
    func pageController(_ pageController: AquamanPageViewController, contentScrollViewDidScroll scrollView: UIScrollView)
    
    /// Method call when viewController will cache
    ///
    /// - Parameters:
    ///   - pageController: AquamanPageViewController
    ///   - viewController: target viewController
    ///   - index: target viewController's index
    func pageController(_ pageController: AquamanPageViewController, willCache viewController: (UIViewController & AquamanChildViewController), forItemAt index: Int)
    
    
    /// Method call when viewController did display
    ///
    /// - Parameters:
    ///   - pageController: AquamanPageViewController
    ///   - viewController: target viewController
    ///   - index: target viewController's index
    func pageController(_ pageController: AquamanPageViewController, didDisplay viewController: (UIViewController & AquamanChildViewController), forItemAt index: Int)
    
    
    /// Method call when menuView is adsorption
    ///
    /// - Parameters:
    ///   - pageController: AquamanPageViewController
    ///   - isAdsorption: is adsorption
    func pageController(_ pageController: AquamanPageViewController, menuView isAdsorption: Bool)
    
    
    /// Asks the delegate for the margins to apply to content.
    /// - Parameter pageController: AquamanPageViewController
    func contentInsetFor(_ pageController: AquamanPageViewController) -> UIEdgeInsets
    
}
