import UIKit

class CustomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let transitionType: TransitionType
    let isPresenting: Bool
    let duration: TimeInterval

    init(transitionType: TransitionType, isPresenting: Bool, duration: TimeInterval = 0.3) {
        self.transitionType = transitionType
        self.isPresenting = isPresenting
        self.duration = duration
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
              let fromView = transitionContext.view(forKey: .from) else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        toView.frame = containerView.bounds 

        let finalFrame = containerView.bounds

        switch transitionType {
            case .fade:
                animateFadeTransition(fromView: fromView, toView: toView, finalFrame: finalFrame, transitionContext: transitionContext)
            case .slide(let direction):
                animateSlideTransition(fromView: fromView, toView: toView, direction: direction, finalFrame: finalFrame, transitionContext: transitionContext)
            case .scale:
                animateScaleTransition(fromView: fromView, toView: toView, finalFrame: finalFrame, transitionContext: transitionContext)
            case .custom(let animation):
                animation(fromView, toView, .flipFromRight)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            case .push, .pop:
                animateDefaultTransition(fromView: fromView, toView: toView, finalFrame: finalFrame, transitionContext: transitionContext)
        }
    }

    private func animateFadeTransition(fromView: UIView, toView: UIView, finalFrame: CGRect, transitionContext: UIViewControllerContextTransitioning) {
        toView.frame = finalFrame
        toView.alpha = 0.0

        UIView.animate(withDuration: duration, animations: {
            fromView.alpha = 0.0
            toView.alpha = 1.0
        }, completion: { _ in
            fromView.alpha = 1.0
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func animateSlideTransition(fromView: UIView, toView: UIView, direction: TransitionDirection, finalFrame: CGRect, transitionContext: UIViewControllerContextTransitioning) {
        var startFrame = finalFrame
        switch direction {
            case .left:
                startFrame.origin.x = isPresenting ? finalFrame.width : -finalFrame.width
            case .right:
                startFrame.origin.x = isPresenting ? -finalFrame.width : finalFrame.width
            case .top:
                startFrame.origin.y = isPresenting ? finalFrame.height : -finalFrame.height
            case .bottom:
                startFrame.origin.y = isPresenting ? -finalFrame.height : finalFrame.height
        }

        toView.frame = startFrame

        UIView.animate(withDuration: duration, animations: {
            fromView.frame = self.isPresenting ? startFrame : finalFrame
            toView.frame = finalFrame
        }, completion: { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func animateScaleTransition(fromView: UIView, toView: UIView, finalFrame: CGRect, transitionContext: UIViewControllerContextTransitioning) {
        toView.frame = finalFrame
        toView.transform = CGAffineTransform(scaleX: isPresenting ? 0.1 : 1.0, y: isPresenting ? 0.1 : 1.0)

        UIView.animate(withDuration: duration, animations: {
            fromView.transform = CGAffineTransform(scaleX: self.isPresenting ? 1.0 : 0.1, y: self.isPresenting ? 1.0 : 0.1)
            toView.transform = CGAffineTransform(scaleX: self.isPresenting ? 1.0 : 0.1, y: self.isPresenting ? 1.0 : 0.1)
        }, completion: { _ in
            fromView.transform = .identity
            fromView.removeFromSuperview()
            toView.transform = .identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }

    private func animateDefaultTransition(fromView: UIView, toView: UIView, finalFrame: CGRect, transitionContext: UIViewControllerContextTransitioning) {
        let offset = finalFrame.width
        toView.frame = finalFrame.offsetBy(dx: isPresenting ? offset : -offset, dy: 0)

        UIView.animate(withDuration: duration, animations: {
            fromView.frame = finalFrame.offsetBy(dx: self.isPresenting ? -offset : offset, dy: 0)
            toView.frame = finalFrame
        }, completion: { _ in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
