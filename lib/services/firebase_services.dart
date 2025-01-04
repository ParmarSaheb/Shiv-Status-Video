import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class AppFirebaseServices {

  static final AppFirebaseServices _instance = AppFirebaseServices._internal();
  factory AppFirebaseServices() => _instance;
  AppFirebaseServices._internal();

  // Firebase Analytics and Crashlytics instances
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  // Initialize Firebase services
  void initialize() {
    _crashlytics.setCrashlyticsCollectionEnabled(true);
  }

  // Log an event for Analytics
  Future<void> logEvent({required String eventName, Map<String, Object>? parameters}) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  // Log a screen view event for Analytics
  Future<void> logScreenView({required String screenName, String? screenClass}) async {
    await _analytics.logEvent(
      name: 'screen_view', // Using a string instead of FirebaseAnalyticsEvent
      parameters: {
        'screen_name': screenName,
        'screen_class': screenClass ?? screenName,
      },
    );
  }

  // Set a user property for Analytics
  Future<void> setUserProperty({required String name, required String value}) async {
    await _analytics.setUserProperty(
      name: name,
      value: value,
    );
  }

  // Set a user ID for Analytics and Crashlytics
  Future<void> setUserId({required String userId}) async {
    await _analytics.setUserId(id: userId);
    await _crashlytics.setUserIdentifier(userId);
  }

  // Log a non-fatal error to Crashlytics
  Future<void> logError(dynamic exception, StackTrace stackTrace) async {
    await _crashlytics.recordError(exception, stackTrace);
  }



  // Log custom messages to Crashlytics
  Future<void> logMessage(String message) async {
    await _crashlytics.log(message);
  }
}
