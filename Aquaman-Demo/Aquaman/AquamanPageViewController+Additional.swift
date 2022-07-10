

import Foundation
import UIKit

extension AquamanPageViewController {
    public func updateHeaderViewHeight(animated: Bool = false,
                                       duration: TimeInterval = 0.25,
                                       completion: ((Bool) -> Void)? = nil) {
        
        headerViewHeight = headerViewHeightFor(self)
        sillValue = headerViewHeight - menuViewPinHeight
        
        mainScrollView.headerViewHeight = headerViewHeight
        headerViewConstraint?.constant = headerViewHeight
        
        var manualHandel = false
        if mainScrollView.contentOffset.y < sillValue {
            currentChildScrollView?.contentOffset = currentChildScrollView?.am_originOffset ?? .zero
            currentChildScrollView?.am_isCanScroll = false
            mainScrollView.am_isCanScroll = true
            manualHandel = true
        } else if mainScrollView.contentOffset.y == sillValue  {
            mainScrollView.am_isCanScroll = false
            manualHandel = true
        }
        let isAdsorption = (headerViewHeight <= 0.0) ? true : !mainScrollView.am_isCanScroll
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.mainScrollView.layoutIfNeeded()
                if manualHandel {
                    self.pageController(self, menuView: isAdsorption)
                }
            }) { (finish) in
                completion?(finish)
            }
        } else {
            self.pageController(self, menuView: isAdsorption)
            completion?(true)
        }
    }
    
    public func setSelect(index: Int, animation: Bool) {
        let offset = CGPoint(x: contentScrollView.bounds.width * CGFloat(index),
                             y: contentScrollView.contentOffset.y)
        contentScrollView.setContentOffset(offset, animated: animation)
        if animation == false {
            contentScrollViewDidEndScroll(contentScrollView)
        }
    }
    
    public func scrollToTop(_ animation: Bool) {
        currentChildScrollView?.setContentOffset(currentChildScrollView?.am_originOffset ?? .zero, animated: true)
        mainScrollView.am_isCanScroll = true
        mainScrollView.setContentOffset(.zero, animated: animation)
    }
    
    public func reloadData() {
        mainScrollView.isUserInteractionEnabled = false
        clear()
        obtainDataSource()
        updateOriginContent()
        setupDataSource()
        view.layoutIfNeeded()
        if originIndex > 0 {
            setSelect(index: originIndex, animation: false)
        } else {
            showChildViewContoller(at: originIndex)
            didDisplayViewController(at: originIndex)
        }
        mainScrollView.isUserInteractionEnabled = true
    }
}


extension AquamanPageViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == mainScrollView {
            pageController(self, mainScrollViewDidScroll: scrollView)
            let offsetY = scrollView.contentOffset.y
            if offsetY >= sillValue {
                scrollView.contentOffset = CGPoint(x: 0, y: sillValue)
                currentChildScrollView?.am_isCanScroll = true
                scrollView.am_isCanScroll = false
                pageController(self, menuView: !scrollView.am_isCanScroll)
            } else {
                let notScroll = (scrollView.am_isCanScroll == false)
                pageController(self, menuView: notScroll)
                if notScroll{
                    scrollView.contentOffset = CGPoint(x: 0, y: sillValue)
                }
            }
        } else {
            pageController(self, contentScrollViewDidScroll: scrollView)
            layoutChildViewControlls()
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView {
            mainScrollView.isScrollEnabled = false
        }
    }

    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == contentScrollView {
            mainScrollView.isScrollEnabled = true
            if decelerate == false {
                contentScrollViewDidEndScroll(contentScrollView)
            }
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView {
            contentScrollViewDidEndScroll(contentScrollView)
        }
    }
    
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == contentScrollView {
            contentScrollViewDidEndScroll(contentScrollView)
        }
    }
    
    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        guard scrollView == mainScrollView else {
            return false
        }
        currentChildScrollView?.setContentOffset(currentChildScrollView?.am_originOffset ?? .zero, animated: true)
        return true
    }
    
}

extension AquamanPageViewController {
    internal func childScrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.am_isCanScroll == false {
            scrollView.contentOffset = scrollView.am_originOffset ?? .zero
        }
        let offsetY = scrollView.contentOffset.y
        if offsetY <= (scrollView.am_originOffset ?? .zero).y {
            scrollView.contentOffset = scrollView.am_originOffset ?? .zero
            scrollView.am_isCanScroll = false
            mainScrollView.am_isCanScroll = true
        }
    }
}
