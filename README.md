# Assessment App

## Description

Assessment App is a Flutter project that demonstrates the usage of Flutter widgets and libraries to create a character list and detail screen. The app displays character information, including images and details, in both portrait and landscape orientations on different devices.

## Features

1. Supports portrait and landscape orientations on phones and tablets.
2. On phones, the list and detail are separate screens, while on tablets, both appear on the same screen.
3. Displays a vertically scrollable list of character names in text-only format.
4. Offers search functionality to filter the character list based on query text.
5. Clicking on an item loads the detail view of that character, including image, title, and description.
6. Uses the "Icon" field URL from the API JSON response to display character images. Placeholder images are used for missing or blank URLs.
7. Provides two app variants with different names, package names, and URLs while sharing a single codebase.
8. Includes unit tests using Flutter Test, Mocktail, and Bloc Test for critical and high-priority functionality.

## Dependencies

The app uses the following dependencies:

- Flutter (SDK version: >=3.0.6 <4.0.0)
- [cupertino_icons](https://pub.dev/packages/cupertino_icons): Flutter's built-in icon font for Cupertino icons.
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): State management library for Flutter applications.
- [http](https://pub.dev/packages/http): Library for making HTTP requests.
- [equatable](https://pub.dev/packages/equatable): Library for comparing Dart objects in a consistent manner.
- [connectivity_plus](https://pub.dev/packages/connectivity_plus): Library for checking network connectivity.
- [logger](https://pub.dev/packages/logger): Library for logging messages.

## Dev Dependencies

The app uses the following dev dependencies:

- [flutter_test](https://flutter.dev/docs/testing): Flutter's testing library for writing widget tests.
- [bloc_test](https://pub.dev/packages/bloc_test): Library for testing BLoC components.
- [mocktail](https://pub.dev/packages/mocktail): Library for creating mock objects in Dart tests.
- [flutter_lints](https://pub.dev/packages/flutter_lints): Recommended lints for promoting good coding practices.

## Architecture

The app follows the Clean Architecture pattern, utilizing BLoC for state management.

## Variants

The app has two variants:

1. **Variant 1**:

   - Name: Simpsons Character Viewer
   - Data API: [http://api.duckduckgo.com/?q=simpsons+characters&format=json](http://api.duckduckgo.com/?q=simpsons+characters&format=json)
   - Package/Bundle name: com.sample.simpsonsviewer

2. **Variant 2**:
   - Name: The Wire Character Viewer
   - Data API: [http://api.duckduckgo.com/?q=the+wire+characters&format=json](http://api.duckduckgo.com/?q=the+wire+characters&format=json)
   - Package/Bundle name: com.sample.wireviewer

These variants were created using build flavors in Flutter. The corresponding settings for each variant were configured in the native iOS and Android projects.

## Getting Started

To run the app, ensure you have Flutter and Dart installed. Clone the repository, navigate to the project directory, and run the following commands:
Navigate to the project directory using the command line:

cd assessment_app

Run the App
Use the following commands to run the app for each variant:

1. **Variant 1**:

   Variant 1: Simpsons Character Viewer

   flutter run -t lib/main_simpson.dart --flavor simpson

   This command will launch the app with the settings for the Simpsons Character Viewer variant.

2. **Variant 2**:

   Variant 2: The Wire Character Viewer

   flutter run -t lib/main_wire.dart --flavor wire

   This command will launch the app with the settings for The Wire Character Viewer variant.

launch.json has also been modified to start these variants from vscode.
