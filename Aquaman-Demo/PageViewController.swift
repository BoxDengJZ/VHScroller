import UIKit
import MJRefresh

import Trident

class PageViewController: AquamanPageViewController {

    var indexPath = IndexPath(row: 0, section: 0)
    lazy var menuView: TridentMenuView = {
        let view = TridentMenuView(parts:
            .normalTextColor(UIColor.gray),
            .selectedTextColor(UIColor.blue),
            .normalTextFont(UIFont.systemFont(ofSize: 15.0)),
            .selectedTextFont(UIFont.systemFont(ofSize: 15.0, weight: .medium)),
            .switchStyle(.line),
            .sliderStyle(
                SliderViewStyle(parts:
                    .backgroundColor(.blue),
                    .height(3.0),
                    .cornerRadius(1.5),
                    .position(.bottom),
                    .extraWidth(indexPath.row == 0 ? -10.0 : 4.0),
                    .shape(indexPath.row == 0 ? .line : .triangle)
                )
            ),
            .bottomLineStyle(
                BottomLineViewStyle(parts:
                    .hidden(indexPath.row == 0 ? false : true)
                )
            )
        )
        view.delegate = self
        return view
    }()
    
    private let headerView = HeaderView()
    private lazy var count = indexPath.row == 0 ? 3 : 0
    var headerViewHeightXx: CGFloat = 200.0
    private var menuViewHeight: CGFloat = 54.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        mainScrollView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(updateData))
        switch indexPath.row {
        case 0:
            menuView.titles = ["Superman", "Batman", "Wonder Woman"]
        case 1:
            headerView.isHidden = true
            menuView.isHidden = true
            mainScrollView.mj_header?.beginRefreshing()
        default:
            break
        }
    }
    
    @objc func updateData() {
            self.headerView.isHidden = false
            self.menuView.isHidden = false
            self.menuView.titles = ["Superman", "Batman", "Wonder Woman", "The Flash"]
            self.count = self.menuView.titles.count
            self.headerViewHeightXx = 120.0
            self.menuViewHeight = 54.0
            self.reloadData()
            if self.mainScrollView.mj_header?.isRefreshing ?? false {
                self.mainScrollView.mj_header?.endRefreshing()
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch indexPath.row {
        case 0:
            navigationController?.setNavigationBarHidden(true, animated: animated)
        default:
            break
        }
    }
    
    override func headerViewFor(_ pageController: AquamanPageViewController) -> UIView {
        return headerView
    }
    
    override func headerViewHeightFor(_ pageController: AquamanPageViewController) -> CGFloat {
        return headerViewHeightXx
    }
    
    override func numberOfViewControllers(in pageController: AquamanPageViewController) -> Int {
        return count
    }
    
    override func pageController(_ pageController: AquamanPageViewController, viewControllerAt index: Int) -> (UIViewController & AquamanChildViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if index == 0 {
            return storyboard.instantiateViewController(withIdentifier: "SupermanViewController") as! SupermanViewController
        } else if index == 1 {
            return storyboard.instantiateViewController(withIdentifier: "BatmanViewController") as! BatmanViewController
        } else if index == 2 {
            return storyboard.instantiateViewController(withIdentifier: "WonderWomanViewController") as! WonderWomanViewController
        } else {
            return storyboard.instantiateViewController(withIdentifier: "TheFlashViewController") as! TheFlashViewController
        }
    }
    
    // 默认显示的 ViewController 的 index
    override func originIndexFor(_ pageController: AquamanPageViewController) -> Int {
        switch indexPath.row {
        case 0:
            return 0
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func menuViewFor(_ pageController: AquamanPageViewController) -> UIView {
        return menuView
    }
    
    override func menuViewHeightFor(_ pageController: AquamanPageViewController) -> CGFloat {
        return menuViewHeight
    }
    
    override func menuViewPinHeightFor(_ pageController: AquamanPageViewController) -> CGFloat {
        return 0.0
    }

    
    override func pageController(_ pageController: AquamanPageViewController, contentScrollViewDidScroll scrollView: UIScrollView) {
        menuView.updateLayout(scrollView)
    }
    
    override func pageController(_ pageController: AquamanPageViewController,
                                 contentScrollViewDidEndScroll scrollView: UIScrollView) {
        
    }
    
    override func pageController(_ pageController: AquamanPageViewController, menuView isAdsorption: Bool) {
        menuView.backgroundColor = isAdsorption ? .red : .white
    }
    
    
    override func pageController(_ pageController: AquamanPageViewController, willDisplay viewController: (UIViewController & AquamanChildViewController), forItemAt index: Int) {
    }
    
    override func pageController(_ pageController: AquamanPageViewController, didDisplay viewController: (UIViewController & AquamanChildViewController), forItemAt index: Int) {
        menuView.checkState(animation: true)
    }
    
    override func contentInsetFor(_ pageController: AquamanPageViewController) -> UIEdgeInsets {
        switch indexPath.row {
        case 0:
            return UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0)
        case 1:
            return .zero
        default:
            return .zero
        }
    }
}


extension PageViewController: TridentMenuViewDelegate {
    func menuView(_ menuView: TridentMenuView, didSelectedItemAt index: Int) {
        guard index < count else {
            return
        }
        switch indexPath.row {
        case 0:
            setSelect(index: index, animation: true)
        case 1:
            setSelect(index: index, animation: false)
        default:
            break
        }
    }
}
