# NavigationStackAPI

A powerful and flexible navigation snippets for SwiftUI that provides custom transitions, deep linking support, and programmatic navigation control.

![RocketSim_Recording_iPhone_16_Pro_6 3_2025-01-20_00 47 09](https://github.com/user-attachments/assets/5f4a31a7-292b-4731-abb4-94216ee3711f)


## Features

- Custom transition animations (fade, slide, scale)
- Deep linking support
- Programmatic navigation control
- Tab-based navigation
- Stack depth tracking
- Multiple navigation operations (push, pop, replace)

## Installation

1. Clone the repository
2. Open the project in Xcode
3. Build and run

## Usage

### Basic Navigation

```swift
// Push a new view
NavigationService.shared.push(DynamicView(pageNo: 1))

// Pop current view
NavigationService.shared.pop()

// Pop to root
NavigationService.shared.popToRoot()
```

### Custom Transitions

```swift
// Fade transition
NavigationService.shared.push(
    DynamicView(pageNo: 1),
    transition: .fade
)

// Slide transition
NavigationService.shared.push(
    DynamicView(pageNo: 1),
    transition: .slide(direction: .right)
)

// Scale transition
NavigationService.shared.push(
    DynamicView(pageNo: 1),
    transition: .scale
)
```

### Deep Linking

The app supports deep linking with the following URL scheme:
```
NavigationStackAPI://navigate/[screen_type]/[page_number]?path=[navigation_path]
```

Example deep links:
```
NavigationStackAPI://navigate/screen/2
NavigationStackAPI://navigate/profile/1
NavigationStackAPI://navigate/settings/1
```

With navigation path:
```
NavigationStackAPI://navigate/screen/3?path=screen:1,profile,settings
```

### Key Components

1. **NavigationService**: Singleton service managing navigation operations
   - Handles push/pop operations
   - Manages navigation stack
   - Controls transitions

2. **CustomTransitionAnimator**: Handles custom transition animations
   - Fade transitions
   - Slide transitions
   - Scale transitions
   - Custom animation support

3. **DeepLinkHandler**: Manages deep linking functionality
   - URL parsing
   - Navigation path handling
   - Screen type routing

## Requirements

- iOS 18.0+
- Xcode 16.0+
- Swift 5.0+

## License

This project is available under the MIT license.

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## Author

Lakshay Gupta
