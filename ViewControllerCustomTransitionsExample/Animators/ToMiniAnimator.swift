import Foundation
import UIKit

final class ToMiniAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private let destinationFrame: CGRect

    init(destinationFrame: CGRect) {
        self.destinationFrame = destinationFrame
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fullScreenVC = transitionContext.viewController(forKey: .from) as? FullScreenViewController,
        let parentVC = transitionContext.viewController(forKey: .to) as? ParentViewController else {
            return
        }

        guard let miniPlayerView = parentVC.miniViewController.view else { return }

        guard let parentSnapshot = parentVC.view.snapshotView(afterScreenUpdates: true) else { return }
        let containerView = transitionContext.containerView

        parentSnapshot.frame = destinationFrame
        parentSnapshot.alpha = 0.75

        containerView.addSubview(parentSnapshot)
        parentVC.view.isHidden = true

        let duration = transitionDuration(using: transitionContext)

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
                    parentSnapshot.alpha = 0.75
                }

                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                    parentSnapshot.alpha = 0.5
                }

                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                    parentSnapshot.alpha = 0
                }
        },
            completion: { _ in
                parentSnapshot.removeFromSuperview()
                miniPlayerView.alpha = 1
                parentVC.view.isHidden = false
                if transitionContext.transitionWasCancelled {
                    parentVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

