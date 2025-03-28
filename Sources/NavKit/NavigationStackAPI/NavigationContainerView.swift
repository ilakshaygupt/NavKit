import SwiftUI
#if os(iOS)
import Foundation
import UIKit



// Learn more @ https://developer.apple.com/documentation/swiftui/UIViewControllerRepresentable
public struct NavigationContainerView<Content: View>: UIViewControllerRepresentable {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let hostingController = UIHostingController(rootView: content)
        let navigationController = UINavigationController(rootViewController: hostingController)
        NavigationService.shared.setup(with: navigationController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
} 

#endif