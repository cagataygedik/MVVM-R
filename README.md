# MVVM-R Car Listings App

> **A comprehensive iOS application demonstrating modern MVVM-R architecture with hybrid SwiftUI/UIKit implementation**

## 📖 Table of Contents

- [Overview](#-overview)
- [What is MVVM-R?](#-what-is-mvvm-r)
- [Architecture Deep Dive](#-architecture-deep-dive)
- [Project Structure](#-project-structure)
- [Key Features](#-key-features)
- [Learning Objectives](#-learning-objectives)
- [Technical Implementation](#-technical-implementation)
- [Getting Started](#-getting-started)
- [API Integration](#-api-integration)
- [Contributing](#-contributing)

## 🎯 Overview

This project serves as an **educational reference** for iOS developers who want to understand and implement the **MVVM-R (Model-View-ViewModel-Router)** architecture pattern. It demonstrates a real-world car listings application that seamlessly combines **SwiftUI** and **UIKit**, showcasing modern iOS development practices.

### Why This Project?

- 📚 **Educational Focus**: Designed specifically for learning MVVM-R architecture
- 🏗️ **Production-Ready Patterns**: Real-world implementation, not just toy examples
- 🔄 **Hybrid UI Approach**: Shows how to effectively combine SwiftUI and UIKit
- 🌐 **Modern Networking**: Generic, protocol-based networking layer
- 🧪 **Testable Architecture**: Clean separation of concerns for easy unit testing

## 🏛️ What is MVVM-R?

MVVM-R extends the traditional MVVM pattern by adding a **Router** component, creating a more scalable and maintainable architecture for iOS applications.

### Architecture Components

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│    Model    │    │    View     │    │  ViewModel  │    │   Router    │
│             │    │             │    │             │    │             │
│ • Car       │◄───┤ • LoginView │◄───┤ • Combines  │◄───┤ • Navigation│
│ • User      │    │ • TableView │    │   Publishers│    │ • Flow      │
│ • Listing   │    │ • SwiftUI   │    │ • Business  │    │ • Injection │
│             │    │   Views     │    │   Logic     │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

### Benefits of MVVM-R

- **🎯 Single Responsibility**: Each component has a clear, focused purpose
- **🔄 Testability**: Easy to unit test ViewModels and business logic
- **📱 Navigation Separation**: Router handles all navigation concerns
- **🔗 Reactive Programming**: Combine framework for data flow
- **🏗️ Scalability**: Easy to add new features and screens

## 🔧 Architecture Deep Dive

### 1. Base Classes Foundation

The project establishes a solid foundation with generic base classes:

#### BaseRouter
```swift
class BaseRouter: BaseRouterProtocol {
    internal let appRouter: Router
    
    init(appRouter: Router) {
        self.appRouter = appRouter
    }
}
```

#### BaseViewModel
```swift
class BaseViewModel<R: BaseRouterProtocol>: ObservableObject, BaseViewModelProtocol {
    let router: R
    var cancellables = Set<AnyCancellable>()
    
    init(router: R) {
        self.router = router
    }
}
```

### 2. Router Pattern Implementation

#### Centralized App Router
```swift
class Router: ObservableObject, BaseRouterProtocol {
    @Published var currentRoute: Route = .login
    @Published var isAuthenticated = false
    
    func login() {
        isAuthenticated = true
        currentRoute = .main
    }
}
```

#### Feature-Specific Routers
```swift
final class CarListingsRouter: BaseRouter, CarDetailRoute {}
final class LoginRouter: BaseRouter {
    func loginSuccessful() {
        appRouter.login()
    }
}
```

### 3. Hybrid UI Architecture

#### SwiftUI Views with ViewModels
```swift
struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        // SwiftUI declarative UI
    }
}
```

#### UIKit Integration
```swift
final class CarListingsViewController: BaseViewController<CarListingsViewModel> {
    // UIKit TableView with reactive data binding
    private func setupBindings() {
        viewModel.$cars
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
}
```

### 4. Navigation Protocol Pattern

```swift
protocol CarDetailRoute {
    func pushCarDetail(for car: Car)
}

extension CarDetailRoute where Self: BaseRouter {
    func pushCarDetail(for car: Car) {
        // Type-safe navigation implementation
    }
}
```

### 5. Generic Networking Layer

#### Protocol-Based Design
```swift
protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}
```

#### Generic API Client
```swift
open class BaseAPIClient: BaseAPIClientProtocol {
    public func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        // Generic networking implementation
    }
}
```

## 📁 Project Structure

```
MVVM-R/
├── 🏗️ Base/                    # Foundation classes
│   ├── BaseRouter.swift        # Router abstraction
│   ├── BaseViewModel.swift     # ViewModel base class
│   ├── BaseViewController.swift # UIKit base controller
│   └── BaseHostingViewController.swift # SwiftUI hosting
│
├── 🌐 Networking/              # Generic networking layer
│   ├── BaseAPIClient.swift     # Protocol-based HTTP client
│   ├── Endpoint.swift          # API endpoint protocol
│   ├── Car/
│   │   ├── CarEndpoint.swift   # Car API endpoints
│   │   └── CarService.swift    # Car data service
│   └── Login/
│       └── LoginService.swift  # Authentication service
│
├── 🏠 Root/                    # App entry point
│   └── RootViewController.swift # Main app coordinator
│
├── 🗺️ Routing/                 # Navigation management
│   ├── AppCoordinator.swift    # App-level coordination
│   ├── Router.swift           # Central router
│   └── Route.swift            # Route definitions
│
├── 🚗 CarListings/             # Car listings feature
│   ├── CarListingsRouter.swift
│   ├── CarListingsViewModel.swift
│   ├── CarListingsViewController.swift # UIKit implementation
│   ├── CarTableViewCell.swift
│   └── SwiftUI/
│       ├── CarListingsSwiftUIView.swift # SwiftUI implementation
│       └── ReusableViews/
│           └── CarRowView.swift
│
├── 📱 CarDetail/               # Car detail feature
│   ├── CarDetailRouter.swift
│   ├── CarDetailViewModel.swift
│   ├── CarDetailView.swift     # SwiftUI implementation
│   └── CarDetailRoute.swift    # Navigation protocol
│
├── 🔐 Login/                   # Authentication feature
│   ├── LoginRouter.swift
│   ├── LoginViewModel.swift
│   └── LoginView.swift         # SwiftUI implementation
│
├── ❤️ Favorites/               # Favorites feature
│   ├── FavoritesRouter.swift
│   ├── FavoritesViewModel.swift
│   └── FavoritesViewController.swift # UIKit implementation
│
├── ⚙️ Settings/                # Settings feature
│   ├── SettingsRouter.swift
│   ├── SettingsViewModel.swift
│   ├── SettingsView.swift      # SwiftUI implementation
│   └── SettingsViewController.swift # UIKit hosting
│
├── 📊 Models/                  # Data models
│   ├── Car.swift              # Domain model
│   ├── User.swift             # User model
│   └── Listing.swift          # API response model
│
└── 🎛️ TabBar/                  # Tab navigation
    └── MainTabBarController.swift
```

## ✨ Key Features

### 🔐 Authentication Flow
- **SwiftUI-based** login screen with reactive form validation
- **Async/await** authentication service
- **Automatic navigation** on login success

### 🚗 Car Listings
- **Dual Implementation**: Both UIKit TableView and SwiftUI List
- **Real API Integration**: Fetches data from arabamd.com sandbox API
- **Infinite Scrolling**: Pagination with loading indicators
- **Pull-to-Refresh**: Smooth data refreshing

### 📱 Car Details
- **SwiftUI detail view** with high-quality images
- **Reactive favorites** system with instant UI updates
- **Type-safe navigation** using protocol extensions

### ❤️ Favorites Management
- **Persistent favorites** using shared manager
- **Reactive UI updates** across all screens
- **Empty state handling** with appropriate messaging

### ⚙️ Settings
- **Simple logout** functionality
- **Proper state cleanup** on authentication changes

## 🎓 Learning Objectives

After studying this project, you should understand:

### ✅ MVVM-R Architecture
- [ ] How to structure an iOS app using MVVM-R
- [ ] The role and responsibilities of each architectural component
- [ ] How to create reusable base classes and protocols

### ✅ Navigation & Routing
- [ ] Centralized navigation management with Router pattern
- [ ] Protocol-based navigation for type safety
- [ ] Dependency injection for ViewModels and Routers

### ✅ Reactive Programming
- [ ] Using Combine for reactive data flow
- [ ] @Published properties and subscribers
- [ ] Binding ViewModels to Views

### ✅ Hybrid UI Development
- [ ] Integrating SwiftUI views in UIKit apps
- [ ] Using UIHostingController effectively
- [ ] When to choose SwiftUI vs UIKit

### ✅ Modern Networking
- [ ] Protocol-based networking architecture
- [ ] Generic API clients with async/await
- [ ] Proper error handling and loading states

### ✅ Clean Code Practices
- [ ] Separation of concerns
- [ ] Dependency injection
- [ ] Protocol-oriented programming

## 🛠️ Technical Implementation

### Dependencies
- **SnapKit**: Programmatic Auto Layout for UIKit components
- **Kingfisher**: Async image loading and caching
- **Combine**: Reactive programming framework (built-in)

### iOS Requirements
- **iOS 15.0+**: Required for async/await and modern SwiftUI features
- **Xcode 14.0+**: Latest Swift features and SwiftUI improvements

### Architecture Highlights

#### 1. Reactive Data Flow
```swift
// ViewModel publishes data
@Published var cars: [Car] = []

// View subscribes to updates
viewModel.$cars
    .receive(on: DispatchQueue.main)
    .sink { [weak self] _ in
        self?.tableView.reloadData()
    }
    .store(in: &cancellables)
```

#### 2. Type-Safe Navigation
```swift
protocol CarDetailRoute {
    func pushCarDetail(for car: Car)
}

// Any router can conform to provide car detail navigation
final class CarListingsRouter: BaseRouter, CarDetailRoute {}
```

#### 3. Generic Networking
```swift
// Any endpoint can be defined
enum CarEndpoint: Endpoint {
    case getListings(skip: Int, take: Int)
}

// Generic request handling
let cars: [Listing] = try await carService.request(endpoint: .getListings(skip: 0, take: 10))
```

## 🚀 Getting Started

### Prerequisites
- Xcode 14.0 or later
- iOS 15.0+ deployment target
- Swift 5.7+

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/mvvm-r-car-listings.git
   cd mvvm-r-car-listings
   ```

2. **Open in Xcode**
   ```bash
   open MVVM-R.xcodeproj
   ```

3. **Install dependencies**
   Dependencies are managed via Swift Package Manager and should resolve automatically.

4. **Build and run**
   - Select a simulator or device
   - Press `⌘ + R` to build and run

### Demo Credentials
- **Username**: `demo`
- **Password**: `password`

## 🌐 API Integration

The app integrates with the **arabamd.com sandbox API** to demonstrate real-world data fetching:

### API Endpoint
```
https://sandbox.arabamd.com/api/v1/listing?sort=1&sortDirection=0&take=10
```

### Features
- **Real car listings** from Turkish automotive marketplace
- **Pagination support** for infinite scrolling
- **Image loading** with Kingfisher caching
- **Error handling** for network failures

### Data Mapping
The app demonstrates clean separation between API models and domain models:

```swift
// API Response Model
struct Listing: Codable {
    let id: Int
    let title: String
    let price: Int
    // ... other API fields
}

// Domain Model
struct Car: Identifiable {
    let id: Int
    let brand: String
    let model: String
    // ... clean domain fields
    
    init(listing: Listing) {
        // Smart mapping logic
    }
}
```

## 🤝 Contributing

This project is designed for educational purposes. Contributions that enhance the learning experience are welcome:

### Areas for Enhancement
- [ ] Add unit tests for ViewModels
- [ ] Implement Core Data persistence
- [ ] Add more complex navigation flows
- [ ] Enhance error handling and user feedback
- [ ] Add accessibility features
- [ ] Implement dark mode support

### How to Contribute
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📚 Further Reading

- [Apple's MVVM Documentation](https://developer.apple.com/documentation/swiftui/model-data)
- [Combine Framework Guide](https://developer.apple.com/documentation/combine)
- [SwiftUI and UIKit Integration](https://developer.apple.com/documentation/swiftui/uihostingcontroller)
- [Coordinator Pattern in iOS](https://khanlou.com/2015/10/coordinators-redux/)

## 📄 License

This project is available under the MIT License. See the LICENSE file for more info.

---

**Built with ❤️ for iOS developers learning modern architecture patterns**
