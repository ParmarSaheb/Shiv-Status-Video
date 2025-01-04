import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_audience_network_constant.dart';

enum RewardedVideoAdResult {
  /// Rewarded video error.
  error,

  /// Rewarded video loaded successfully.
  loaded,

  /// Rewarded video clicked.
  clicked,

  /// Rewarded video impression logged.
  loggingImpression,

  /// Rewarded video played till the end. Use it to reward the user.
  videoComplete,

  /// Rewarded video closed.
  videoClosed,
}

class FacebookRewardedVideoAd {
  static void Function(RewardedVideoAdResult, dynamic)? _listener;

  static const _channel = MethodChannel(rewardedVideoChannel);

  static Future<bool?> loadRewardedVideoAd({
    String placementId = "YOUR_PLACEMENT_ID",
    Function(RewardedVideoAdResult, dynamic)? listener,
  }) async {
    try {
      final args = <String, dynamic>{
        "id": placementId,
      };

      if (Platform.isIOS) {
        return false;
      }

      final result = await _channel.invokeMethod(
        loadRewardedVideoMethod,
        args,
      );
      _channel.setMethodCallHandler(_rewardedMethodCall);
      _listener = listener;

      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool?> showRewardedVideoAd({int delay = 0}) async {
    try {
      final args = <String, dynamic>{
        "delay": delay,
      };

      final result = await _channel.invokeMethod(
        showRewardedVideoMethod,
        args,
      );

      return result;
    } on PlatformException {
      return false;
    }
  }

  /// Removes the rewarded video Ad.
  static Future<bool?> destroyRewardedVideoAd() async {
    try {
      final result = await _channel.invokeMethod(destroyRewardedVideoMethod);
      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<dynamic> _rewardedMethodCall(MethodCall call) {
    switch (call.method) {
      case rewardedVideoCompleteMethod:
        if (_listener != null) {
          _listener!(RewardedVideoAdResult.videoComplete, call.arguments);
        }
        break;
      case rewardedVideoClosedMethod:
        if (_listener != null) {
          _listener!(RewardedVideoAdResult.videoClosed, call.arguments);
        }
        break;
      case errorMethod:
        if (_listener != null) {
          _listener!(RewardedVideoAdResult.error, call.arguments);
        }
        break;
      case loadedMethod:
        if (_listener != null) {
          _listener!(RewardedVideoAdResult.loaded, call.arguments);
        }
        break;
      case clickedMethod:
        if (_listener != null) {
          _listener!(RewardedVideoAdResult.clicked, call.arguments);
        }
        break;
      case loggingImpressionMethod:
        if (_listener != null) {
          _listener!(RewardedVideoAdResult.loggingImpression, call.arguments);
        }
        break;
    }
    return Future.value(true);
  }
}
