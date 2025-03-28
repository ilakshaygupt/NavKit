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
