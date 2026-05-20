# 📱 Mobile Flutter - PRM393 Study Materials

Welcome to the **PRM393 Mobile Programming** repository. This project is a streamlined Flutter application designed to showcase core mobile development concepts, starting with models, static memory state management, and declarative data operations in Dart.

---

## 🚀 Features & Components

### 📦 The `Product` Model (`lib/product.dart`)
A robust representation of an e-commerce product featuring clean architecture principles:

*   **Attributes:**
    *   `id` (String): Unique identifier.
    *   `name` (String): Product name.
    *   `image` (String): Image URL.
    *   `price` (double): Current price of the product.
*   **Key Operations & Methods:**
    *   `Product.fromJson(Map<String, dynamic> json)`: Factory constructor for seamless JSON serialization.
    *   `Product.copyWith(...)`: Facilitates immutable state updates.
    *   `Product.add(Product)`: Adds a new product to the central static memory list.
    *   `Product.edit(Product)`: Safely updates an existing product.
    *   `Product.find(String id)`: Retrieves a specific product by its ID.
    *   `Product.search({String? query, double? minPrice, double? maxPrice})`: Performs flexible, multi-criteria filtering.
    *   `Product.increasePrice()`: Leverages Dart's **declarative `.map()`** operator to elevate all product prices by `10%` in a functional programming style.

---

## 🛠️ Getting Started

### Prerequisites
Make sure you have Flutter installed and configured on your machine.
```bash
# Check your local flutter environment
flutter doctor
```

### Installation & Run
1.  Clone the repository:
    ```bash
    git clone https://github.com/AnhDucNgo1245/mobile_flutter.git
    ```
2.  Navigate to the project folder:
    ```bash
    cd flutter_prm
    ```
3.  Install dependencies:
    ```bash
    flutter pub get
    ```
4.  Run code static analysis:
    ```bash
    flutter analyze
    ```
5.  Run the application:
    ```bash
    flutter run
    ```

---

## 📂 Project Directory Structure
```text
lib/
├── models/         # (Future growth) App data models
├── widgets/        # Reusable custom UI components
├── product.dart    # Product model & static data manager
└── main.dart       # Application entry point
```

---
*Created and maintained as part of the PRM393 coursework.*
