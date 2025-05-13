# LinkedIn Clone - Flutter MVVM Architecture

This project is a LinkedIn UI clone built with Flutter, following the MVVM (Model-View-ViewModel) architecture pattern. The application provides a comprehensive UI experience similar to the LinkedIn app, with emphasis on modular code organization, reusability, and separation of concerns.

![LinkedIn Clone Screenshot](assets/images/linkedin_illustration.png)

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Setup & Installation](#setup--installation)
- [Testing](#testing)
- [State Management](#state-management)
- [Navigation System](#navigation-system)
- [Custom UI Components](#custom-ui-components)
- [Performance Optimization](#performance-optimization)
- [Security Considerations](#security-considerations)

## Features

- **Authentication System**
  - Smooth Login & Signup flows with email-password authentication
  - Form validation and error handling
  - Persistent authentication state

- **LinkedIn-Style UI**
  - Complete user flow (splash → welcome → login/signup → home)
  - LinkedIn-style post feed with engagement stats
  - Stories section at top of feed
  - Like, comment, share, and save post actions
  - Post image display with rounded corners
  - Custom app bar and bottom navigation
  
- **Profile Page**
  - User profile view similar to LinkedIn
  - Connection analytics display (profile views, post impressions)
  - "Creator mode" toggle functionality
  - Experience section with company logos
  - Open-to-work banner option
  
- **Smooth Navigation**
  - Custom page transitions (fade and slide-up animations)
  - Centralized navigation service
  - Route management for easy navigation between screens

- **Enhanced UX**
  - Loading overlays for smooth user experience during data fetching
  - Responsive design that adapts to different screen sizes
  - Error states with user-friendly messages
  - Optimized performance with minimal rebuilds

## Architecture

The application follows the MVVM (Model-View-ViewModel) architecture pattern:

### Model
Data structures that represent the core data of the application.
- `UserModel`: Represents user information including profile data, connections, and experiences
- `PostModel`: Represents post data with engagement metrics and media content

### View
UI components that display information to the user.
- Screen components (full pages like LoginView, ProfileView)
- Reusable UI widgets (e.g., ConnectionAnalyticsWidget, OpenToWorkCard)
- No business logic in the view layer, only UI rendering and user interaction

### ViewModel
Handles business logic and communicates between View and data layer.
- `BaseViewModel`: Core functionality for all view models including loading state and error handling
- `AuthViewModel`: Authentication operations (login, signup, validation)
- `ProfileViewModel`: User profile operations and analytics
- `HomeViewModel`: Home screen functionality and feed management

### Repository
Handles data operations and provides a clean API to the ViewModel.
- `AuthRepository`: Authentication operations with abstracted data sources
- `UserRepository`: User data operations
- `PostRepository`: Post-related data operations

## Project Structure

```
/lib
├── config/            # App configuration settings
├── core/              # Core utilities and constants
├── data/              # Data sources and API clients
├── models/            # Data models
├── repository/        # Data repositories 
├── res/               # Resources (colors, dimensions, strings)
├── routing/           # Navigation service and routes
├── services/          # Application services
├── utils/             # Utility functions
├── view/              # UI components
│   ├── screens/       # Full screen views
│   └── widgets/       # Reusable UI components
├── view_model/        # ViewModels for business logic
└── main.dart          # Application entry point
```

## Setup & Installation

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions
- Compatible device or emulator

### Getting Started

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/ilabs_assignment.git
   ```

2. Navigate to the project directory:
   ```
   cd ilabs_assignment
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Run the application:
   ```
   flutter run
   ```

## Testing

The application includes comprehensive test coverage with over 20 test cases:

### Model Tests
- Tests for `UserModel` validation and initialization
- Tests for data serialization and deserialization

### ViewModel Tests
- Tests for `AuthViewModel` authentication logic
- Tests for `ProfileViewModel` state management
- Tests for loading states and error handling

### UI Widget Tests
- Tests for custom UI components rendering
- Tests for user interactions and event handling

### Routing Tests
- Tests for custom page transitions (fade and slide-up)
- Tests for navigation service functionality

### Running Tests

Run all tests with:
```
flutter test
```

Run specific test files with:
```
flutter test test/model_tests.dart
flutter test test/view_model_test.dart
flutter test test/routing_tests.dart
flutter test test/ui_widget_test.dart
```

## State Management

This application uses Provider for state management:

- **Provider**: Lightweight state management solution
- **ChangeNotifier**: Base class for all ViewModels
- **Consumer Widgets**: For efficient UI updates
- **Context Extensions**: For convenient ViewModel access

Example usage:

```dart
// Providing ViewModels
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => AuthViewModel()),
    ChangeNotifierProvider(create: (_) => ProfileViewModel()),
  ],
  child: MaterialApp(...),
)

// Consuming in UI
Consumer<AuthViewModel>(
  builder: (context, authViewModel, _) {
    return Button(
      onPressed: authViewModel.login,
      child: Text('Login'),
    );
  },
)
```

## Navigation System

The application implements a custom navigation system with smooth transitions and central management:

### Custom Page Routes
- **FadePageRoute**: Custom route with elegant fade transition animation
- **SlideUpPageRoute**: Custom route with professional slide-up animation

Example:
```dart
// Using custom transitions
Navigator.push(
  context, 
  FadePageRoute(page: ProfileView())
);
```

### Navigation Service
A singleton service that provides app-wide navigation capabilities:

```dart
NavigationService.instance.navigateTo(Routes.profile);
```

### Routes
Centralized route definitions in the `Routes` class:

```dart
static Map<String, WidgetBuilder> get routes => {
  splash: (context) => const SplashScreen(),
  welcome: (context) => const WelcomeView(),
  login: (context) => const LoginView(),
  // ...more routes
};
```

### View Models
- `BaseViewModel`: Provides common functionality for all view models including loading state, error handling, and analytics tracking
- `AuthViewModel`: Handles login and signup operations
- `HomeViewModel`: Manages the home feed data and operations
- `ProfileViewModel`: Manages user profile data and operations

## Custom UI Components

### Profile Components
- **ProfileHeader**: Displays user information with connection status
- **ConnectionAnalyticsWidget**: Shows profile views, post impressions, and search appearances
- **OpenToWorkCard**: Displays "Open to Work" status similar to LinkedIn
- **ExperienceItem**: Lists professional experiences with company logos

### Feed Components
- **LinkedInPostWidget**: Modular widget for displaying LinkedIn-style posts
- **LinkedInStoriesSection**: Shows story circles at the top of the feed
- **LinkedInAppBar**: Custom app bar with LinkedIn styling
- **LinkedInBottomNavigationWithFab**: Bottom navigation bar with FAB for posting

### Common Components
- **LoadingOverlay**: Provides a smooth loading experience during async operations
- **CustomTextField**: Styled text input fields with validation
- **LinkedInButton**: Custom styled buttons for primary and secondary actions

## Performance Optimization

This application implements several performance optimization techniques:

- **Efficient Rebuilds**: Using `Consumer` widgets to minimize unnecessary rebuilds
- **Lazy Loading**: Loading data only when needed
- **State Management**: Using Provider for efficient state updates
- **Memory Management**: Proper disposal of controllers and streams
- **Caching**: Image caching for better performance

## Security Considerations

Security best practices implemented in this application:

- **Secure Authentication**: Proper validation and error handling
- **Input Sanitization**: Preventing injection attacks
- **Error Handling**: Graceful error handling without exposing sensitive info
- **Code Organization**: Following SOLID principles for maintainable and secure code

## Future Improvements

- Implement real API integration with Firebase
- Add post creation functionality
- Add messaging features
- Implement notifications system
- Add job search functionality
- Enhance profile editing capabilities
- Add network connection handling

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
