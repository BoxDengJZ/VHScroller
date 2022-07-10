

import UIKit


class SupermanViewController: UIViewController, AquamanChildViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    func aquamanChildScrollView() -> UIScrollView {
        return tableView
    }
}


extension SupermanViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "Update head view height"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Set select"
        } else {
            cell.textLabel?.text = "Title"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let pageViewControllerXX = parent as? PageViewController else {
            return
        }
        
        if indexPath.row == 0 {
            
            tableView.isUserInteractionEnabled = false
            var array = [250, 80, 150, 0]
            let headerViewHeight = pageViewControllerXX.headerViewHeight
            array.removeAll(where: {$0 == Int(headerViewHeight)})
            pageViewControllerXX.headerViewHeight = CGFloat(array.randomElement()!)
            
            pageViewControllerXX.updateHeaderViewHeight(animated: true,
                                                      duration: 0.25) { (finish) in
                tableView.isUserInteractionEnabled = true
            }
        } else if indexPath.row == 1 {
            
            pageViewControllerXX.setSelect(index: pageViewControllerXX.currentIndex + 1,
                                         animation: [true, false].randomElement()!)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
