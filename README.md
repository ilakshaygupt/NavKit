# NavKit

NavKit is a powerful and flexible navigation solution for SwiftUI applications that provides programmatic navigation control while maintaining SwiftUI's declarative syntax.

## Features

- 🚀 Programmatic navigation from anywhere in your app
- 📱 Full SwiftUI integration
- 🎯 Type-safe navigation
- 🔄 Support for complex navigation flows
- 🎨 Customizable navigation behaviors

## Requirements

- iOS 13.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

### Swift Package Manager

1. In Xcode, select **File** → **Add Packages...**
2. Enter the package URL: `https://github.com/ilakshaygupt/NavKit.git`
3. Select **Up to Next Major Version** and specify **1.0.0**
4. Click **Add Package**

### Manual SPM Integration

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/ilakshaygupt/NavKit.git", from: "1.0.2")
]
```

## Quick Start Guide

### 1. Setup NavigationContainerView

First, wrap your root view in a `NavigationContainerView`:

```swift
import SwiftUI
import NavKit

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationContainerView {
                RootView()
            }
        }
    }
}
```

### 2. Create Your Views

Create the views you want to navigate between:

```swift
struct RootView: View {
    var body: some View {
        VStack {
            Text("Welcome to NavKit!")
            Button("Go to Detail") {
                // Navigation code will go here
            }
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
    }
}
```

### 3. Setup Navigation Service

Initialize the NavigationService in your view:

```swift
struct RootView: View {
    var body: some View {
        VStack {
            Text("Welcome to NavKit!")
            Button("Go to Detail") {
                NavigationService.shared.push(DetailView())
            }
        }
    }
}
```

## Navigation Methods

NavKit provides several navigation methods:

### Push Navigation

```swift
// Push a new view
NavigationService.shared.push(DetailView())

// Push with animation
NavigationService.shared.push(DetailView(), animated: true)
```

### Pop Navigation

```swift
// Pop one level
NavigationService.shared.pop()

// Pop to root
NavigationService.shared.popToRoot()

// Pop multiple levels
NavigationService.shared.pop(count: 2)
```

### Replace Navigation

```swift
// Replace current view
NavigationService.shared.replace(with: NewView())

// Replace entire stack
NavigationService.shared.replaceStack(with: NewView())
```

## Advanced Usage

### Passing Data

```swift
struct DetailView: View {
    let data: String
    
    var body: some View {
        Text(data)
    }
}

// In your navigation code
NavigationService.shared.push(DetailView(data: "Hello from NavKit!"))
```

### Custom Transitions

```swift
NavigationService.shared.push(DetailView(), transition: .custom)
```

### Navigation Events

```swift
NavigationService.shared.onNavigationComplete = { 
    print("Navigation completed")
}
```

## Best Practices

1. **Single Source of Truth**: Use NavigationService as the single source of truth for navigation.
2. **View Organization**: Keep your views modular and independent.
3. **State Management**: Handle state changes appropriately during navigation.
4. **Error Handling**: Implement proper error handling for navigation failures.

## Common Issues and Solutions

### Issue: Navigation Not Working
- Ensure NavigationContainerView is properly set up
- Check if NavigationService is properly initialized
- Verify view hierarchy is correct

### Issue: Animations Not Working
- Confirm animation parameters are correct
- Check if device settings allow animations
- Verify iOS version compatibility


## License

NavKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
