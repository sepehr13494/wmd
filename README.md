###TODOS
socials sign in ios config  
https://pub.dev/packages/google_sign_in
https://pub.dev/packages/twitter_login
https://pub.dev/packages/sign_in_with_apple
https://pub.dev/packages/local_auth

deeplink ios config  
https://docs.flutter.dev/development/ui/navigation/deep-linking

#for hive and mocks
flutter pub run build_runner build --delete-conflicting-outputs

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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

# running app per environment (values -> dev, qa, uat)

flutter run --dart-define=env=qa

#our flutter version
flutter version 3.3.8

