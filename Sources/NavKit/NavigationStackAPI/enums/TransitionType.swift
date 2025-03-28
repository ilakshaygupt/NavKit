//
//  TransitionType.swift
//  NavKit
//
//  Created by Lakshay Gupta on 28/03/25.
//


#if os(iOS)
import Foundation
import UIKit

public enum TransitionType {
    case push
    case pop
    case fade
    case slide(direction: TransitionDirection)
    case scale
    case custom((UIView, UIView, UIView.AnimationTransition) -> Void)
}
#endif
