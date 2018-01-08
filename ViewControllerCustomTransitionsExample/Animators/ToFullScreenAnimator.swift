import Foundation
import UIKit

final class ToFullScreenAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private let miniOriginFrame: CGRect

    init(miniOriginFrame: CGRect) {
        self.miniOriginFrame = miniOriginFrame
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let parentVC = transitionContext.viewController(forKey: .from) as? ParentViewController,
        let miniVC = parentVC.miniViewController,
        let fullScreenVC = transitionContext.viewController(forKey: .to) as? FullScreenViewController else {
                return
        }
        guard let fullScreenSnapshot = fullScreenVC.view.snapshotView(afterScreenUpdates: true) else { return }

        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: fullScreenVC)

        fullScreenSnapshot.frame = CGRect(origin: miniOriginFrame.origin, size: finalFrame.size)

        containerView.addSubview(fullScreenVC.view)
        containerView.addSubview(fullScreenSnapshot)

        fullScreenVC.view.alpha = 0
        let duration = transitionDuration(using: transitionContext)

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {

                }

                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {

                }

                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                    fullScreenSnapshot.frame = finalFrame
                }
        },
            completion: { _ in
                fullScreenVC.view.alpha = 1
                miniVC.view.alpha = 0
                fullScreenSnapshot.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
