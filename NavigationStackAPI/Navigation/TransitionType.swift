import UIKit

enum TransitionType {
    case push
    case pop
    case fade
    case slide(direction: TransitionDirection)
    case scale
    case custom((UIView, UIView, UIView.AnimationTransition) -> Void)
}

enum TransitionDirection {
    case left
    case right
    case top
    case bottom
} 