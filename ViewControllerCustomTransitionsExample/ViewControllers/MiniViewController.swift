import Foundation
import UIKit

final class MiniViewController: UIViewController {

    @IBOutlet weak var miniTitle: UILabel!
    var containerView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }

    @IBAction func didPressPresentButton(_ sender: Any) {
        let toViewController = (storyboard?.instantiateViewController(withIdentifier: "FullScreenViewController"))! as! FullScreenViewController
        toViewController.transitioningDelegate = self
        present(toViewController, animated: true, completion: nil)
    }
}

extension MiniViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return ToFullScreenAnimator(miniOriginFrame: containerView.frame)
    }
}
