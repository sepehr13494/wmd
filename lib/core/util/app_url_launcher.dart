import 'package:url_launcher/url_launcher_string.dart';

class AppUrlLauncher{
  static appLaunchUrl(String url){
    launchUrlString(url,mode: LaunchMode.externalApplication);
  }
}