# SwiftUI Navigation

This project provides a customizable navigation solution for SwiftUI applications.  Using the `NavigationManager` class and the `NavigationView` struct, you can easily navigate between pages, add custom back buttons, and control the navigation path.

## Features

* **Simple and Easy to Use:** The `NavigationManager` class offers a straightforward API for navigating between views.
* **Customizable Back Button:** The `BackButton` struct allows you to create custom back buttons that match your app's design.
* **NavigationPath Integration:** Leverages SwiftUI's `NavigationPath` for managing the navigation stack and enabling dynamic navigation.
* **Singleton Instance:** Access the navigation manager from anywhere in your app using `NavigationManager.shared`.
* **View Builder Support:** Easily define your views within `NavigationView` using the `@ViewBuilder` attribute.
* **Back Button Visibility Control:** Control the visibility of the back button for each view using the `backButtonVisible` parameter.

## Installation

Add the `NavigationManager.swift` file to your project to start using this navigation solution.

1. Add the `NavigationManager.swift` file to your project.
2. Wrap your main view with `NavigationStack` and add `NavigationManager` as a `@StateObject` or `@ObservedObject`:

```swift
import SwiftUI

struct ContentView: View {
    @StateObject var navigationManager = NavigationManager.shared

    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            // Your starting view
            FirstView()
              .navigationDestination(for: NavigationView<AnyView>.self) { destination in
                    destination.content
                }
        }
      .environmentObject(navigationManager)
    }
}
