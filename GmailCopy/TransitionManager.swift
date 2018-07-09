//
//  TransitionManager.swift
//  TransitionDelegate
//
//  Created by Daniel Hjartstrom on 04/01/2018.
//  Copyright © 2018 Daniel Hjartstrom. All rights reserved.
//
import UIKit

enum Direction {
    case top, bottom, left, right
}

enum PresentationStatus {
    case present, dismiss
}

enum BackgroundStyle {
    case dimmed, blurred, none
}

class TransitionManager: NSObject, UIViewControllerTransitioningDelegate {

    var percentage: CGFloat
    var duration: Double
    var tapToDismiss: Bool
    var direction: Direction
    var backgroundStyle: BackgroundStyle
    var presentationController: PresentationController!
    var shouldMinimizeBackground: Bool
    
    init(percentage: CGFloat, duration: Double, tapToDismiss: Bool, direction: Direction, backgroundStyle: BackgroundStyle, shouldMinimizeBackground: Bool) {
        self.percentage = percentage
        self.duration = duration
        self.tapToDismiss = tapToDismiss
        self.direction = direction
        self.backgroundStyle = backgroundStyle
        self.shouldMinimizeBackground = shouldMinimizeBackground
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimation(percentage: percentage, transition: .present, duration: duration, direction: direction, shouldMinimizeBackground: shouldMinimizeBackground)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionAnimation(percentage: percentage, transition: .dismiss, duration: duration, direction: direction, shouldMinimizeBackground: shouldMinimizeBackground)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        presentationController = PresentationController(presentedViewController: presented, presenting: presenting, percentage: percentage, tapToDismiss: tapToDismiss, direction: direction, backgroundStyle: backgroundStyle)
        return presentationController
    }
    
}

class PresentationController: UIPresentationController {
    
    var percentage: CGFloat = 0
    var direction: Direction
    var backgroundStyle: BackgroundStyle
    var dimViewAlphaMax: CGFloat = 1.0
    var presentedViewControllerOrigin: CGPoint = CGPoint.zero

    lazy var panGesture: UIPanGestureRecognizer = {
        return UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
    }()
    
    lazy var tapRecognizer: UITapGestureRecognizer = {
        let temp = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        temp.numberOfTapsRequired = 1
        return temp
    }()
    
    private var backgroundView: PresentationBackgroundView!
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, percentage: CGFloat, tapToDismiss: Bool, direction: Direction, backgroundStyle: BackgroundStyle) {
        self.percentage = percentage
        self.direction = direction
        self.backgroundStyle = backgroundStyle
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.view.addGestureRecognizer(panGesture)
        
        backgroundView = PresentationBackgroundView(frame: CGRect.zero, style: backgroundStyle)
        
        if tapToDismiss {
            backgroundView.addGestureRecognizer(tapRecognizer)
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        let container = frameOfPresentedViewInContainerView
        switch direction {
        case .bottom:
            presentedView?.frame = CGRect(x: 0, y: container.height - (container.height * percentage), width: container.width, height: (container.height * percentage))
        case .top:
            presentedView?.frame = CGRect(x: 0, y: 0, width: container.width, height: (container.height * percentage))
        case .right:
            presentedView?.frame = CGRect(x: container.width - (container.width * percentage), y: 0, width: container.width * percentage, height: container.height)
        case .left:
            presentedView?.frame = CGRect(x: 0, y: 0, width: container.width * percentage, height: container.height)
        }
    }
    
    override func presentationTransitionWillBegin() {
        backgroundView.frame = self.containerView!.bounds
        backgroundView.alpha = 0
        containerView?.insertSubview(backgroundView, at: 0)
        
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: {[weak self] (_) -> Void in
            self?.setAlpha((self?.dimViewAlphaMax)!)
        })
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentedViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: {[weak self] (_) -> Void in
            self?.setAlpha(0)
        })
    }
    
    @objc func dismiss() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        presentedViewControllerOrigin = presentedViewController.view.frame.origin
    }
    
    @objc func didPan(_ sender: UIPanGestureRecognizer) {
        guard let container = containerView else { return }
        let translation = sender.translation(in: presentedViewController.view)
        let origin = presentedViewController.view.frame.origin
        let panFrame = presentedViewController.view.frame
        let velocity = sender.velocity(in: presentedViewController.view)
        
        switch sender.state {
        case .began, .changed:
       
            switch direction {
            case .top:
                if origin.y <= 0.0 && translation.y <= presentedViewControllerOrigin.y {
                    presentedViewController.view.frame.origin.y = translation.y
                    setAlpha(1.0 + (translation.y / panFrame.height))
                } else {
                    returnToOrigin()
                }
            case .bottom:
                if origin.y >= 0.0 && translation.y >= presentedViewControllerOrigin.y {
                    presentedViewController.view.frame.origin.y = translation.y + container.frame.height - (container.frame.height * percentage)
                    setAlpha(1.0 - (translation.y / panFrame.height))
                } else {
                    returnToOrigin()
                }
            case .left:
                if origin.x <= 0.0 && presentedViewController.view.frame.origin.x <= presentedViewControllerOrigin.x {
                    presentedViewController.view.frame.origin.x = translation.x
                    setAlpha(1.0 + (translation.x / panFrame.width))
                } else {
                    returnToOrigin()
                }
                
            case .right:
                if origin.x >= 0.0 && presentedViewController.view.frame.origin.x >= presentedViewControllerOrigin.x {
                    presentedViewController.view.frame.origin.x = translation.x + container.frame.width - (container.frame.width * percentage)
                    setAlpha(1.0 - (translation.x / panFrame.width))
                } else {
                    returnToOrigin()
                }
            }
        
        case .ended:
            switch direction {
            case .top:
                if origin.y < -(container.frame.height * percentage) * 0.8 {
                    dismiss()
                } else {
                    returnToOrigin()
                }
            case .bottom:
                if origin.y > container.frame.height * 0.8 {
                    dismiss()
                } else {
                    returnToOrigin()
                }
            case .left:
                if origin.x < -(container.frame.width * percentage) * 0.8 {
                    dismiss()
                } else {
                    returnToOrigin()
                }
            case .right:
                if origin.x > container.frame.width * 0.8 {
                    dismiss()
                } else {
                    returnToOrigin()
                }
            }
        default:
            break
        }
    }
    
    private func returnToOrigin() {
        presentingViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.presentedViewController.view.frame.origin = self.presentedViewControllerOrigin
            self.setAlpha(1.0)
            self.presentingViewController.view.layoutIfNeeded()
        }
    }
    
    private func setAlpha(_ alpha: CGFloat) {
        backgroundView.alpha = alpha
    }
    
}

class TransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    var percentage: CGFloat
    var duration: Double
    var transition: PresentationStatus
    var direction: Direction
    var shouldMinimizeBackground: Bool
    
    init(percentage: CGFloat, transition: PresentationStatus, duration: Double, direction: Direction, shouldMinimizeBackground: Bool) {
        self.percentage = percentage
        self.transition = transition
        self.duration = duration
        self.direction = direction
        self.shouldMinimizeBackground = shouldMinimizeBackground
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view else { return }
        guard let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view else { return }
        
        switch transition {
        case .present:
            container.addSubview(toView)
            container.clipsToBounds = true
            toView.layer.masksToBounds = true
            animateIn(container: container, fromView: fromView, toView: toView, transitionContext: transitionContext)
        case .dismiss:
            animateOut(container: container, fromView: fromView, toView: toView, transitionContext: transitionContext)
        }
    }
    
    private func animateIn(container: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        toView.layoutIfNeeded()
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
            
            switch self.direction {
            case .top:
                toView.frame.origin.y += container.frame.height * self.percentage
            case .bottom:
                toView.frame.origin.y -= container.frame.height * self.percentage
            case .left:
                toView.frame.origin.x += container.frame.width * self.percentage
            case .right:
                toView.frame.origin.x -= toView.frame.width * self.percentage
            }

            if self.shouldMinimizeBackground {
                fromView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? UINavigationController)?.setNavigationBarHidden(true, animated: false)
            }
            
            }, completion: { (completion) in
                transitionContext.completeTransition(!(transitionContext.transitionWasCancelled))
                toView.layoutIfNeeded()
        })
    }
    
    private func animateOut(container: UIView, fromView: UIView, toView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        fromView.layoutIfNeeded()
        UIView.animate(withDuration: duration / 2, delay: 0, options: .curveEaseInOut, animations: { [unowned self] in
          
                switch self.direction {
                case .top:
                    fromView.frame.origin.y = -(container.frame.height * self.percentage)
                case .bottom:
                    fromView.frame.origin.y = fromView.bounds.height + (toView.frame.height - (container.frame.height * self.percentage))
                case .left:
                    fromView.frame.origin.x -= toView.frame.width
                case .right:
                    fromView.frame.origin.x += toView.frame.width
                }
            
            if self.shouldMinimizeBackground {
                toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? UINavigationController)?.setNavigationBarHidden(false, animated: false)
            }
            
            }, completion: { (completion) in
                transitionContext.completeTransition(!(transitionContext.transitionWasCancelled))
                fromView.layoutIfNeeded()
            })
        }
    }
