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

# SSL Pinning. This command will save ssl crt for defined domain 
## qa
openssl s_client -showcerts -servername apim-aio-tst-01.azure-api.net -connect apim-aio-tst-01.azure-api.net:443 < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > assets/certificates/qa.crt

## dev
openssl s_client -showcerts -servername apigw-wmd-dev.azure-api.net -connect apigw-wmd-dev.azure-api.net:443 < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > assets/certificates/dev.crt
## uat
openssl s_client -showcerts -servername apimaz-weu-tfo-mvp-qa.azure-api.net -connect apimaz-weu-tfo-mvp-qa.azure-api.net:443 < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > assets/certificates/uat.crt
## prod
openssl s_client -showcerts -servername apigw-wmd-prod-01.azure-api.net -connect apigw-wmd-prod-01.azure-api.net:443 < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > assets/certificates/prod.crt

# Setting up auth0 console
We have 2 kind of auth0 client. 
 - PAM uses official sdk, https://pub.dev/packages/auth0_flutter.
 - TFO user https://pub.dev/packages/flutter_web_auth_2 
for both login we have custom redirect schema, which is bundleId defined in env. For android we have set intent-filter in AndroidManifest.xml for each package. for ios no need to do extra.

For TFO please enter domain without https in .env

