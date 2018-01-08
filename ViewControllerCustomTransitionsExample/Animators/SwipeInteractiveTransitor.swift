import Foundation
import UIKit

final class SwipeInteractiveTransitor: UIPercentDrivenInteractiveTransition {

    var interactionInProgress = false

    private var shouldCompleteTransition = false
    private weak var viewController: UIViewController!

    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        addGestureRecognizer(in: viewController.view)
    }

    // MARK: - Private

    private func addGestureRecognizer(in view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self,
                                                       action: #selector(handleGesture(_:)))
        gesture.edges = .left
        view.addGestureRecognizer(gesture)
    }

    @objc private func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {

        guard let superview = gestureRecognizer.view?.superview else { return }
        let translation = gestureRecognizer.translation(in: superview)
        var progress = (translation.x / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        print("gesture progress \(progress)")
        switch gestureRecognizer.state {
        case .began:
            print("gesture began")
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
        case .changed:
            print("gesture changed")
            shouldCompleteTransition = progress > 0.5
            update(progress)
        case .cancelled:
            print("gesture cancelled")
            interactionInProgress = false
            cancel()
        case .ended:
            print("gesture ended")
            interactionInProgress = false
            if shouldCompleteTransition {
                print("finish")
                finish()
            } else {
                print("cancel")
                cancel()
            }
        default:
            break
        }
    }
}
