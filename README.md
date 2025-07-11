## MVVM-R Car Listings App
This is a sample iOS application built to showcase a clean and scalable architecture using MVVM-R (Model-View-ViewModel-Router). The app demonstrates a hybrid UI approach, seamlessly integrating SwiftUI for modern, declarative views and UIKit for the foundational structure and navigation. It also leverages the Combine framework for reactive data binding.

## 🏛️ Architecture: MVVM-R
The application is built upon the MVVM-R design pattern, which is an extension of the popular MVVM pattern. The "R" stands for Router, which is responsible for handling navigation logic. This separation of concerns leads to a more modular, testable, and maintainable codebase.

The Components

- Model: Represents the data and business logic of the application. In this project, the models are simple data structures.

- Car.swift: Defines the Car object with its properties.

- User.swift: Defines the User object.

- View: The UI of the application. The views are responsible for displaying data and capturing user input. They are designed to be as "dumb" as possible, meaning they don't contain any business logic.

- SwiftUI Views: LoginView.swift, CarDetailView.swift, and reusable components like SpecificationRow.swift are built with SwiftUI for a modern, declarative UI.

- UIKit ViewControllers: The foundational structure of the app is managed by UIKit. RootViewController.swift is the main container that switches between different views based on the navigation state. MainTabBarController.swift, CarListingsViewController.swift, and FavoritesViewController.swift are UIKit view controllers that host SwiftUI views or manage traditional UIKit components like UITableView.

- ViewModel: Acts as a bridge between the Model and the View. It prepares data from the Model for presentation in the View and handles user interactions.

- LoginViewModel.swift: Manages the logic for user authentication.

- CarListingsViewModel.swift: Fetches and provides the list of cars to the CarListingsViewController.

- CarDetailViewModel.swift: Provides the details of a specific car and manages the "favorite" state.

- Router (Coordinator): Manages the navigation flow of the application. It is responsible for creating and presenting views and view controllers.

- AppCoordinator.swift: The main coordinator that initializes the Router and starts the application.

- Router.swift: An ObservableObject that holds the current navigation state (currentRoute) and provides methods to navigate between screens.

- Route.swift: An enum that defines all the possible navigation destinations in the application, ensuring type-safe navigation.

## 📱 Hybrid UI: SwiftUI + UIKit
This application demonstrates a powerful hybrid approach by combining the strengths of both SwiftUI and UIKit.

- UIKit for Structure: The core navigation and view controller hierarchy are managed by UIKit. The SceneDelegate.swift sets up the initial UIWindow with a RootViewController.swift, which in turn uses a MainTabBarController.swift. This provides a stable and well-understood foundation for the app's structure.

- SwiftUI for Content: The actual UI for many of the screens is built with SwiftUI. This allows for rapid development of a modern, declarative, and visually rich user interface.

- Bridging the Gap: The key to this hybrid approach is the UIHostingController. As seen in the RootViewController.swift, UIHostingController is used to embed SwiftUI views (like LoginView and CarDetailView) within the UIKit view controller hierarchy. This allows for a seamless integration of the two UI frameworks.

```Swift
// Example from RootViewController.swift
case .login:
    let loginView = LoginView(router: coordinator.router)
    newViewController = UIHostingController(rootView: loginView)

case .carDetail(let car):
    let carDetailView = CarDetailView(car: car, router: coordinator.router)
    newViewController = UIHostingController(rootView: carDetailView)
```
## 🔗 Reactive Programming with Combine
The Combine framework is integral to the application's architecture, enabling a reactive data flow between the ViewModels and Views.

- @Published Properties: ViewModels and Managers use the @Published property wrapper to expose properties that can be observed for changes. For example, the cars array in CarListingsViewModel is a published property.

```Swift
// Example from CarListingsViewModel.swift
@Published var cars: [Car] = []
Subscribing to Publishers: The ViewControllers subscribe to these publishers using the .sink() operator. This creates a subscription that receives updates whenever the published property's value changes, allowing the UI to react accordingly.

Swift
// Example from CarListingsViewController.swift
private func setupBindings() {
    viewModel.$cars
        .receive(on: DispatchQueue.main)
        .sink { [weak self] _ in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
        .store(in: &cancellables)
}
```
Benefits of Combine:

- Declarative: It allows you to write more declarative code that clearly expresses your intent.

- Decoupling: It helps to decouple the ViewModels from the Views, as the ViewModels don't need to know about the specific UI components that are observing them.

- Thread Safety: The receive(on:) operator makes it easy to ensure that UI updates are performed on the main thread.

## ✨ Key Features
- User Authentication: A simple login screen to demonstrate navigation and state changes.

- Car Listings: A list of cars fetched from a mock network service.

- Car Details: A detailed view of a selected car.

- Favorites: Users can add and remove cars from a favorites list, which is persisted for the session.

- Hybrid UI: A practical demonstration of using SwiftUI and UIKit together.

- Clean Architecture: A well-organized and scalable project structure.

- Reactive Data Flow: Utilizes the Combine framework for a modern, reactive approach to data binding.

## 🚀 How to Run
Clone the repository.

Open the MVVM-R.xcodeproj file in Xcode.

Build and run the project on a simulator or a physical device.

Credentials for Login:

Username: demo

Password: password

## 📦 Dependencies
SnapKit: Used for programmatic UI layout in the UIKit parts of the application (e.g., CarTableViewCell and FavoritesViewController).
