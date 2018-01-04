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

        guard let fullScreenSnapshot = fullScreenVC.view.snapshotView(afterScreenUpdates: true) else { return }
        let containerView = transitionContext.containerView

        fullScreenSnapshot.frame = destinationFrame

        containerView.addSubview(fullScreenVC.view)

        fullScreenVC.view.isHidden = true
        let duration = transitionDuration(using: transitionContext)

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
                    fullScreenSnapshot.frame = self.destinationFrame
                }

                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                }

                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                }
        },
            completion: { _ in
                fullScreenVC.view.isHidden = false
                fullScreenSnapshot.removeFromSuperview()
                if transitionContext.transitionWasCancelled {
                    parentVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

