import 'package:flutter/services.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_adds/add_interstitial.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_adds/add_rewarded.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_audience_network_constant.dart';

class FacebookAudienceNetwork {
  static const _channel = MethodChannel(mainChannel);

  static Future<bool?> init({String? testingId, bool iOSAdvertiserTrackingEnabled = false}) async {
    Map<String, String?> initValues = {
      "testingId": testingId,
      "iOSAdvertiserTrackingEnabled": iOSAdvertiserTrackingEnabled.toString(),
    };

    try {
      final result = await _channel.invokeMethod(initMethod, initValues);
      return result;
    } on PlatformException {
      return false;
    }
  }

  static Future<bool?> loadInterstitialAd({
    String placementId = "YOUR_PLACEMENT_ID",
    Function(InterstitialAdResult, dynamic)? listener,
  }) async {
    return await FacebookInterstitialAd.loadInterstitialAd(
      placementId: placementId,
      listener: listener,
    );
  }

  static Future<bool?> showInterstitialAd({int? delay}) async {
    return await FacebookInterstitialAd.showInterstitialAd(delay: delay);
  }

  /// Removes the Ad.
  static Future<bool?> destroyInterstitialAd() async {
    return await FacebookInterstitialAd.destroyInterstitialAd();
  }

  static Future<bool?> loadRewardedVideoAd({
    String placementId = "YOUR_PLACEMENT_ID",
    Function(RewardedVideoAdResult, dynamic)? listener,
  }) async {
    return await FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: placementId,
      listener: listener,
    );
  }

  static Future<bool?> showRewardedVideoAd({int delay = 0}) async {
    return await FacebookRewardedVideoAd.showRewardedVideoAd(delay: delay);
  }

  /// Removes the rewarded video Ad.
  static Future<bool?> destroyRewardedVideoAd() async {
    return await FacebookRewardedVideoAd.destroyRewardedVideoAd();
  }
}
