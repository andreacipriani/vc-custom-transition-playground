import UIKit

class ParentViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var miniViewController: MiniViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        miniViewController = (storyboard?.instantiateViewController(withIdentifier: "MiniViewController"))! as! MiniViewController
        miniViewController.containerView = containerView
        addChildViewController(miniViewController)
        miniViewController.view.frame = containerView.bounds
        containerView.addSubview(miniViewController.view)
        miniViewController.didMove(toParentViewController: self)
    }
}
