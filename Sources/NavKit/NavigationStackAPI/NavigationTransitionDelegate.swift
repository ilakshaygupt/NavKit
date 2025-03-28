//
//  NavigationTransitionDelegate.swift
//  NavigationStackAPI
//
//  Created by Lakshay Gupta on 14/01/25.
//

import UIKit
// Learn more @ https://developer.apple.com/documentation/uikit/uinavigationcontrollerdelegate
class NavigationTransitionDelegate: NSObject, UINavigationControllerDelegate {
    var currentTransition: TransitionType?
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let transition = currentTransition else { return nil }
        return CustomTransitionAnimator(transitionType: transition, isPresenting: operation == .push)
    }
}
