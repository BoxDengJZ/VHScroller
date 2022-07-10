

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pageViewController = segue.destination as? PageViewController
            , let cell = sender as? UITableViewCell
            , let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        pageViewController.indexPath = indexPath
    }
}
