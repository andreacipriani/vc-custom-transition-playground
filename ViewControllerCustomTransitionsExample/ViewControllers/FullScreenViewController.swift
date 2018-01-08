import Foundation
import UIKit

final class FullScreenViewController: UIViewController {

    private var swipeInteractiveTransitor: SwipeInteractiveTransitor!

    override func viewDidLoad() {
        super.viewDidLoad()
        swipeInteractiveTransitor = SwipeInteractiveTransitor(viewController: self)
    }

    var containerView: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!

    @IBAction func dismissButtonPressed(_ sender: Any) {
        self.transitioningDelegate = self
        dismiss(animated: true, completion: nil)
    }
}

extension FullScreenViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return ToMiniAnimator(destinationFrame: containerView.frame)
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractiveTransitor
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
        -> UIViewControllerInteractiveTransitioning? {
            return swipeInteractiveTransitor
    }
}
