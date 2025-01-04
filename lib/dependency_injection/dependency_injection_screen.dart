import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shiv_status_video/services/adds/add_new/adds_helper.dart';
import 'package:shiv_status_video/services/firebase_services.dart';
import 'package:shiv_status_video/services/push_notification_services.dart';

class DependencyInjection {
  void init() {
    AdHelper();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Firebase.initializeApp(); // Initialize Firebase

      /// Set up Crashlytics for error reporting
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

      /// Initialize Firebase services for Analytics and Crashlytics
      AppFirebaseServices().initialize();

      /// Initialize Push Notification services
      PushNotificationService().initialize();

      unawaited(MobileAds.instance.initialize());
      // Request tracking permission for iOS 14+
      await initTracking();

    });

  }


  Future<void> initTracking() async {
    final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

}
