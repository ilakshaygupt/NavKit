# NavKit

NavKit is a powerful and flexible navigation framework for iOS applications that enables custom transition animations between view controllers. Built on top of UIKit's navigation system, NavKit provides an elegant API to create beautiful and interactive navigation experiences.

## Features

- Custom transition animations between view controllers
- Built on top of UIKit's native navigation system
- Easy to integrate with existing iOS projects
- Type-safe API
- Support for both push and pop transitions

## Requirements

- iOS 13.0+
- Swift 5.0+
- Xcode 14.0+

## Installation

### Swift Package Manager

Add NavKit to your project through Swift Package Manager by adding it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "YOUR_REPOSITORY_URL", from: "1.0.0")
]
```

Or add it directly through Xcode:
1. File > Add Packages...
2. Enter the repository URL
3. Select the version you want to use

## Usage

### Basic Setup

1. Import NavKit in your view controller:

```swift
import NavKit
```

2. Create a navigation controller with custom transitions:

```swift
let navigationController = UINavigationController()
let transitionDelegate = NavigationTransitionDelegate()
navigationController.delegate = transitionDelegate
```

### Performing Custom Transitions

To perform a custom transition between view controllers:

```swift
// Set the transition type before pushing
transitionDelegate.currentTransition = .yourTransitionType

// Push the view controller
navigationController.pushViewController(destinationVC, animated: true)
```

## Example

Here's a complete example of how to use NavKit:

```swift
class SourceViewController: UIViewController {
    private let transitionDelegate = NavigationTransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = transitionDelegate
    }
    
    func navigateToDetail() {
        let detailVC = DetailViewController()
        transitionDelegate.currentTransition = .slide // or your custom transition
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

NavKit is available under the MIT license. See the LICENSE file for more info. 