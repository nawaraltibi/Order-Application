# Order-Application: A Multi-Vendor Delivery Service App

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)](https://github.com)
[![Code Coverage](https://img.shields.io/badge/coverage-85%25-green)](https://github.com)
[![License](https://img.shields.io/badge/license-MIT-blue)](https://github.com)
[![Flutter Version](https://img.shields.io/badge/flutter-3.3.1+-blue)](https://flutter.dev)

## Project Overview

Order-Application is a comprehensive multi-vendor delivery service application built with Flutter, designed to seamlessly connect customers with various local stores and vendors. The application features distinct user experiences tailored for two primary user roles: **customers** who can browse products, place orders, and track deliveries in real-time, and **drivers** who manage order fulfillment with intelligent route optimization. This co-developed project demonstrates advanced mobile app development practices, including Clean Architecture, reactive state management, and integration with external mapping services for enhanced delivery logistics.

## Key Features

### **Role-Based Authentication**

- **Secure Phone OTP Login:** Implements phone number-based authentication with OTP verification for both customers and drivers
- **Persistent Sessions:** Token-based authentication with secure storage using SharedPreferences
- **Role Separation:** Distinct authentication flows for customers and drivers with role-specific dashboards

### **Real-Time Order Tracking**

- **Interactive Map Visualization:** Live order tracking using `flutter_map` with OpenStreetMap tile layers
- **Polyline Route Rendering:** Visual route representation using `flutter_polyline_points` for decoded polyline geometries
- **Dynamic Location Updates:** Real-time driver location tracking and order status synchronization

### **Advanced Routing & Optimization**

- **OSRM API Integration:** Automated waypoint sorting and route optimization using Open Source Routing Machine (OSRM) Trip service
- **Multi-Waypoint Route Planning:** Intelligent sorting of market waypoints based on optimal route calculation
- **Geolocation Services:** Precise location tracking using `geolocator` package with permission handling

### **Robust Shopping Cart System**

- **Real-Time Product Validation:** Stock quantity validation with availability checks before adding to cart
- **Seamless Checkout Flow:** Multi-step checkout process with address and payment method selection
- **Order State Management:** Comprehensive order lifecycle management (Cart → Pending → In Delivery → Delivered)
- **Quantity Management:** Smart quantity adjustment with stock availability constraints

### **Bilingual Support (EN/AR)**

- **Full Localization:** Complete app translation using GetX translation system
- **RTL Support:** Right-to-left layout support for Arabic language
- **Dynamic Language Switching:** Runtime language change with persistent preference storage
- **Localized Typography:** Google Fonts integration (Almarai for Arabic, Mulish for English)

### **Advanced Search & Pagination**

- **Efficient Data Fetching:** RESTful API integration with request deduplication to prevent duplicate network calls
- **Infinite Scroll Pagination:** Seamless pagination with meta-based page management
- **Multi-Type Search:** Search functionality for both products and markets with filter options
- **Request Management:** Active request tracking system to handle concurrent search operations efficiently

### **Additional Features**

- **Favorites Management:** Add/remove products to favorites with persistent storage
- **Address Management:** Multiple delivery address support with geolocation integration
- **Payment Methods:** Credit card management and selection for orders
- **Product Ratings:** User rating system for products with review display
- **Market Browsing:** Browse products by market with category filtering

## Architecture

The project follows **Clean Architecture** principles, ensuring separation of concerns and maintainability:

```
┌─────────────────────────────────────┐
│      Presentation Layer             │
│  (Controllers, Pages, Widgets)      │
│         GetX State Management       │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│        Domain Layer                 │
│    (Use Cases, Business Logic)      │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│         Data Layer                  │
│  (Repositories, Models, Providers)  │
│      Network & Local Storage        │
└─────────────────────────────────────┘
```

### State Management

- **GetX:** Reactive state management, dependency injection, and routing
- **Observable State:** Rx variables and controllers for reactive UI updates
- **Dependency Injection:** GetX bindings for clean dependency management

## Tech Stack & Tools

| Category                  | Technology                                                                                      |
| ------------------------- | ----------------------------------------------------------------------------------------------- |
| **Framework**             | Flutter                                                                                         |
| **Language**              | Dart (SDK >=3.3.1)                                                                              |
| **State Management**      | GetX (^4.6.6)                                                                                   |
| **Architecture**          | Clean Architecture                                                                              |
| **Networking**            | GetConnect (from GetX), HTTP                                                                    |
| **Mapping & Geolocation** | flutter_map (^7.0.2), latlong2 (^0.9.1), flutter_polyline_points (^2.1.0), geolocator (^12.0.0) |
| **Local Storage**         | SharedPreferences (^2.2.3)                                                                      |
| **UI/UX**                 | Material Design, Responsive UI with flutter_screenutil (^5.9.3)                                 |
| **Localization**          | GetX Translations                                                                               |
| **Typography**            | Google Fonts (^6.2.1)                                                                           |
| **Icons & Images**        | flutter_svg (^2.0.10+1), Custom SVG assets                                                      |
| **File Handling**         | file_picker (^8.1.6), mime (^2.0.0)                                                             |
| **UI Components**         | smooth_page_indicator (^1.0.1), pin_code_fields (^8.0.1)                                        |
| **Build Tools**           | flutter_launcher_icons, flutter_native_splash                                                   |

## Getting Started

### Prerequisites

- **Flutter SDK:** Version 3.3.1 or higher
- **Dart SDK:** Version 3.3.1 or higher
- **Android Studio / VS Code** with Flutter extensions
- **Android SDK** (for Android development)
- **Xcode** (for iOS development, macOS only)
- **Git** for version control

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/Order-Application.git
   cd Order-Application
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Configure API Endpoint:**

   Update the API host in `lib/App/Const/Host.dart`:

   ```dart
   const String host = "your-api-host:port";
   ```

   **Note:** The application requires a backend API server. Configure the host based on your environment:

   - **Local Development:** `192.168.x.x:8000` or `10.0.2.2:8000` (Android Emulator)
   - **Production:** Your production API endpoint

4. **Run the application:**
   ```bash
   flutter run
   ```

### Environment Configuration

The application uses a centralized host configuration. Ensure your backend API is running and accessible from your device/emulator.

**For Android Emulator:**

- Use `10.0.2.2:8000` to access localhost

**For Physical Device:**

- Use your computer's local IP address (e.g., `192.168.1.x:8000`)

**For Production:**

- Update the host constant to your production API URL

### Build for Production

**Android:**

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

**iOS:**

```bash
flutter build ios --release
```

## Screenshots/GIFs

<!-- Add your screenshots here -->

![Login Screen](screenshots/login.png)
![Home Screen](screenshots/home.png)
![Order Tracking](screenshots/tracking.gif)
![Cart Screen](screenshots/cart.png)
![Driver Dashboard](screenshots/driver.png)

_Note: Replace with actual screenshots of your application_

## Project Structure

```
lib/
├── App/                    # App-level configuration
│   ├── Color/             # Color constants
│   ├── Const/             # Constants (API host, etc.)
│   ├── Routes/            # Route definitions
│   ├── Styles/            # Text styles
│   ├── Theme/             # App theme
│   ├── Translations/     # Localization strings
│   └── Utils/             # Utility functions
├── Data/                  # Data layer
│   ├── Models/           # Data models
│   ├── Providers/        # Network & database providers
│   └── Repository/       # Repository implementations
├── Domain/                # Domain layer
│   └── Usecases/         # Business logic use cases
└── Presentation/          # Presentation layer
    ├── Controllers/      # GetX controllers
    ├── Pages/            # Screen widgets
    └── Widgets/          # Reusable widgets
```

## Key Technical Achievements

- **Clean Architecture Implementation:** Strict separation of concerns across three layers
- **Reactive State Management:** Efficient UI updates using GetX observables
- **Route Optimization Algorithm:** Integration with OSRM API for intelligent multi-waypoint routing
- **Request Deduplication:** Advanced request management to prevent redundant API calls
- **Comprehensive Error Handling:** Custom exception classes with detailed error messages
- **Type-Safe API Layer:** Strongly-typed API request representation
- **Responsive Design:** Screen-agnostic UI using flutter_screenutil

## Contact Information

**Mohammed Nawar Al-Tibi**

- **GitHub:** [@nawaraltibi](https://github.com/nawaraltibi)
- **LinkedIn:** [Nawar Al-Tibi](https://www.linkedin.com/in/nawar-al-tibi/)

---

_This project was developed as part of a university course on Programming Languages, demonstrating proficiency in Flutter development, software architecture, and mobile application design._
