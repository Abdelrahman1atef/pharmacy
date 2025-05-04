# Pharmacy Mobile Application 🏥💊

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge)

A cross-platform pharmacy application built using Flutter. The app offers seamless medicine browsing, real-time cart functionality, multi-language support, and a modular architecture for scalability and maintainability.

---

## 🚀 Features

- **🏠 Home Screen**
  - Welcome message
  - Product previews
  - Animated UI and charts

- **🛒 Cart System**
  - Add to cart with quantity updates
  - Price tracking and UI syncing
  - Local storage support

- **⚙️ Settings**
  - Language toggle (Arabic / English)
  - Theme switching (optional)
  - App version and contact options

- **📐 Responsive UI**
  - Built using `flutter_screenutil` for device adaptability

- **🌍 Localization**
  - Powered by `easy_localization`
  - JSON-based language files

- **🧠 State Management**
  - `Cubit` pattern for clean logic separation
  - Modular providers with `Koin`-like dependency injection

---

## 🧱 Technical Stack

| Layer            | Package                        |
|------------------|--------------------------------|
| UI               | `flutter`, `flutter_screenutil`, `flutter_svg` |
| State Management | `flutter_bloc`, `Cubit`        |
| Localization     | `easy_localization`            |
| Routing          | `Navigator 2.0` with named routes |
| Assets Handling  | `flutter_gen`                  |
| Dependency Injection | Custom lightweight provider pattern |

---

## 📁 Project Structure

```bash
lib/
├── app_config_provider/     # App-level config (env settings, DI setup)
├── core/                    # App-wide shared resources (theme, routes, widgets)
├── features/                # Feature-based UI and logic
│   ├── home/
│   ├── cart/
│   └── settings/
├── gen/                     # Auto-generated files (assets)
├── generated/               # Easy_localization generated files
├── l10n/                    # Localization files (ar.json, en.json)
├── utils/                   # Utility classes and helpers
├── app_bloc_providers.dart  # Global Cubit/Bloc registration
├── main.dart                # Entry point
└── pharmacy_app.dart        # Main App widget
