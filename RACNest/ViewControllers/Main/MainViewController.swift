import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerReusableCell(GenericTableCell.self)
        
        tableView.dataSource = viewModel
        tableView.delegate = self
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let item = viewModel.items[indexPath.row]
        
        let viewController = UIStoryboard.defaultStoryboard().instantiateViewControllerWithIdentifier(identifier: item.identifier)
        
        viewController.title = item.title
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
