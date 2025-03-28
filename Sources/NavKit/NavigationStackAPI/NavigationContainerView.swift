import SwiftUI
#if os(iOS)
import Foundation
import UIKit



// Learn more @ https://developer.apple.com/documentation/swiftui/UIViewControllerRepresentable
public struct NavigationContainerView<Content: View>: UIViewControllerRepresentable {
    let content: Content
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public func makeUIViewController(context: Context) -> UINavigationController {
        let hostingController = UIHostingController(rootView: content)
        let navigationController = UINavigationController(rootViewController: hostingController)
        NavigationService.shared.setup(with: navigationController)
        return navigationController
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
} 

#endif