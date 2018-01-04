import Foundation
import UIKit

final class MiniViewController: UIViewController {

    var containerView: UIView!
    @IBOutlet weak var maximizeButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }

    @IBAction func didPressPresentButton(_ sender: Any) {
        let fullScreenViewController = (storyboard?.instantiateViewController(withIdentifier: "FullScreenViewController"))! as! FullScreenViewController
        fullScreenViewController.containerView = containerView
        fullScreenViewController.transitioningDelegate = self
        present(fullScreenViewController, animated: true, completion: nil)
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
