import Foundation
import UIKit

final class MiniViewController: UIViewController {

    var containerView: UIView!
    //private var swipeInteractiveTransitor: SwipeInteractiveTransitor!

    @IBOutlet weak var maximizeButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //swipeInteractiveTransitor = SwipeInteractiveTransitor(viewController: self)
        self.transitioningDelegate = self
    }

    @IBAction func didPressPresentButton(_ sender: Any) {
        let fullScreenViewController = (storyboard?.instantiateViewController(withIdentifier: "FullScreenViewController"))! as! FullScreenViewController
        let origRelToSuperview = view.superview?.convert(view.frame.origin, from: view.superview?.superview)
        containerView = UIView(frame: CGRect(origin: CGPoint(x:0, y:-1.0*(origRelToSuperview?.y)!), size: view.frame.size))
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

//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return swipeInteractiveTransitor
//    }
//
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning)
//        -> UIViewControllerInteractiveTransitioning? {
//            return swipeInteractiveTransitor
//    }
}
