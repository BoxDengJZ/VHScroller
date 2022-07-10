
import UIKit


class TheFlashViewController: UIViewController, AquamanChildViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    func aquamanChildScrollView() -> UIScrollView {
        return scrollView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
}
