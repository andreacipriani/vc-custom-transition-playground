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
        guard let miniVC = transitionContext.viewController(forKey: .from),
        let fullScreenVC = transitionContext.viewController(forKey: .to) as? FullScreenViewController else {
                return
        }

        // prepare for screenshot if needed

        guard let fullScreenSnapshot = fullScreenVC.view.snapshotView(afterScreenUpdates: true) else { return }

        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: fullScreenVC)

        // manipulate screenshot if needed
        fullScreenSnapshot.frame = miniOriginFrame

        containerView.addSubview(fullScreenVC.view)
        containerView.addSubview(fullScreenSnapshot)
        fullScreenVC.view.isHidden = true
        let duration = transitionDuration(using: transitionContext)

        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {

                }

                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
                    fullScreenSnapshot.alpha = 0.6
                }

                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
                    fullScreenSnapshot.alpha = 0.9
                    fullScreenSnapshot.frame = finalFrame
                }
        },
            completion: { _ in
                fullScreenVC.view.isHidden = false
                fullScreenSnapshot.removeFromSuperview()
                miniVC.view.layer.transform = CATransform3DIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
