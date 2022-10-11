###TODOS
socials sign in ios config  
https://pub.dev/packages/google_sign_in
https://pub.dev/packages/twitter_login
https://pub.dev/packages/sign_in_with_apple

#for hive and router and mocks
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
