import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    var miniViewController: MiniViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        miniViewController = (storyboard?.instantiateViewController(withIdentifier: "MiniViewController"))! as! MiniViewController
        addChildViewController(miniViewController)
        miniViewController.view.frame = containerView.bounds
        containerView.addSubview(miniViewController.view)
        miniViewController.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didPressPresentButton(_ sender: Any) {
        let toViewController = (storyboard?.instantiateViewController(withIdentifier: "ToViewController"))! as! ToViewController
        present(toViewController, animated: true, completion: nil)
    }
}
