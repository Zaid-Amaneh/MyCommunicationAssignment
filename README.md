# MyCommunicationAssignment

A Flutter application implementing clean architecture principles for efficient data management and communication between local and remote data sources.

## Features

- Clean Architecture Implementation
- Local Data Storage using Hive
- Remote Data Fetching with HTTP
- State Management using Flutter Bloc
- Offline-first capability
- Toast notifications for user feedback

## Architecture

The project follows Clean Architecture principles with the following layers:

- **Presentation Layer** (`lib/presentation/`)
  - Views
  - ViewModels (Cubits)
  - Widgets

- **Domain Layer** (`lib/domain/`)
  - Entities
  - Repository Interfaces

- **Data Layer** (`lib/data/`)
  - Repository Implementations
  - Local Data Source
  - Remote Data Source
  - Data Models

## Technologies Used

- Flutter SDK ^3.9.2
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) ^9.1.1 - State Management
- [hive](https://pub.dev/packages/hive) ^2.2.3 - Local Storage
- [http](https://pub.dev/packages/http) ^1.5.0 - API Communication
- [equatable](https://pub.dev/packages/equatable) ^2.0.7 - Value Equality
- [intl](https://pub.dev/packages/intl) ^0.20.2 - Internationalization
- [toastification](https://pub.dev/packages/toastification) ^3.0.3 - Toast Messages

## Getting Started

### Prerequisites

- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2
- Git

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Zaid-Amaneh/MyCommunicationAssignment.git
   ```

2. Navigate to the project directory:
   ```bash
   cd MyCommunicationAssignment
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart
├── core/
│   └── utils/
├── data/
│   ├── item_model_adapter.dart
│   ├── item_model.dart
│   ├── item_repository_impl.dart
│   ├── local_data_source.dart
│   └── remote_data_source.dart
├── domain/
│   ├── item_entity.dart
│   └── item_repository.dart
└── presentation/
    ├── viewmodels/
    ├── views/
    └── widgets/
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

- **Zaid Amaneh** - [GitHub Profile](https://github.com/Zaid-Amaneh)
