//
//  NavigationTransitionDelegate.swift
//  NavKit
//
//  Created by Lakshay Gupta on 28/03/25.
//

#if os(iOS)
import Foundation
import UIKit

// Learn more @ https://developer.apple.com/documentation/uikit/uinavigationcontrollerdelegate
public class NavigationTransitionDelegate: NSObject, UINavigationControllerDelegate {
    public var currentTransition: TransitionType?
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let transition = currentTransition else { return nil }
        return CustomTransitionAnimator(transitionType: transition, isPresenting: operation == .push)
    }
}
#endif
