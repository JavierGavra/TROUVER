import 'package:url_launcher/url_launcher.dart';

class PublicFunction {
  static Future<void> launchLink(String link) async {
    Uri url = Uri.parse(link);
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }
}
