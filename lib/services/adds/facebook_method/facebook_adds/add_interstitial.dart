import 'package:flutter/services.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_audience_network_constant.dart';

enum InterstitialAdResult {
  /// Interstitial Ad displayed to the user
  displayed,

  /// Interstitial Ad dismissed by the user
  dismissed,

  /// Interstitial Ad error
  error,

  /// Interstitial Ad loaded
  loaded,

  /// Interstitial Ad clicked
  clicked,

  /// Interstitial Ad impression logged
  loggingImpression,
}

class FacebookInterstitialAd {
  static void Function(InterstitialAdResult, dynamic)? _listener;

  static const _channel = MethodChannel(interstitialAdChannel);

  static Future<bool?> loadInterstitialAd({
    String placementId = "YOUR_PLACEMENT_ID",
    Function(InterstitialAdResult, dynamic)? listener,
  }) async {
    try {
      final args = <String, dynamic>{
        "id": placementId,
      };

      final result = await _channel.invokeMethod(
        loadInterstitialMethod,
        args,
      );
      _channel.setMethodCallHandler(_interstitialMethodCall);
      _listener = listener;

      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool?> showInterstitialAd({int? delay = 0}) async {
    try {
      final args = <String, dynamic>{
        "delay": delay,
      };

      final result = await _channel.invokeMethod(
        showInterstitialMethod,
        args,
      );

      return result;
    } on PlatformException {
      return false;
    }
  }

  /// Removes the Ad.
  static Future<bool?> destroyInterstitialAd() async {
    try {
      final result = await _channel.invokeMethod(destroyInterstitialMethod);
      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<dynamic> _interstitialMethodCall(MethodCall call) {
    switch (call.method) {
      case displayedMethod:
        if (_listener != null) {
          _listener!(InterstitialAdResult.displayed, call.arguments);
        }
        break;
      case dismissedMethod:
        if (_listener != null) {
          _listener!(InterstitialAdResult.dismissed, call.arguments);
        }
        break;
      case errorMethod:
        if (_listener != null) {
          _listener!(InterstitialAdResult.error, call.arguments);
        }
        break;
      case loadedMethod:
        if (_listener != null) {
          _listener!(InterstitialAdResult.loaded, call.arguments);
        }
        break;
      case clickedMethod:
        if (_listener != null) {
          _listener!(InterstitialAdResult.clicked, call.arguments);
        }
        break;
      case loggingImpressionMethod:
        if (_listener != null) {
          _listener!(InterstitialAdResult.loggingImpression, call.arguments);
        }
        break;
    }
    return Future.value(true);
  }
}
