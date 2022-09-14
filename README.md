# wmd

Invest helper project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


#for hive
flutter packages pub run build_runner build

# icon launcher
flutter pub run flutter_launcher_icons:main

# build web
flutter build web --web-renderer html

# build android
flutter build apk --target-platform android-arm,android-arm64

# get sha1
gradlew signingReport

# for localization
flutter gen-l10n