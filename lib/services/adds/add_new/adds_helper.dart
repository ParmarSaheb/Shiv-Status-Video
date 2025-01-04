import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_adds/add_banner.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_adds/add_interstitial.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_adds/add_rewarded.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_audience_network.dart';

class AdHelper {
  static final AdHelper _instance = AdHelper._internal();
  AdManagerInterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  factory AdHelper() {
    MobileAds.instance.initialize();
    _initializeFacebookAds();

    return _instance;
  }

  AdHelper._internal();

  static Future<void> _initializeFacebookAds() async {
    try {
      await FacebookAudienceNetwork.init(testingId: "dd7f30bc-22ad-4d14-a674-c498029ed0ad");
      log("Facebook Audience Network initialized successfully.");
    } catch (error) {
      log("Error initializing Facebook Audience Network: $error");
    }
  }

  String get bannerAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/6300978111'
        : Platform.isIOS
            ? 'ca-app-pub-3940256099942544/2934735716'
            : throw UnsupportedError('Unsupported platform');
  }

  String get interstitialAdUnitId {
    return Platform.isAndroid
        ? "ca-app-pub-3940256099942544/1033173712"
        : Platform.isIOS
            ? "ca-app-pub-3940256099942544/4411468910"
            : throw UnsupportedError("Unsupported platform");
  }

  String get rewardedAdUnitId {
    return Platform.isAndroid
        ? "ca-app-pub-3940256099942544/5224354917"
        : Platform.isIOS
            ? "ca-app-pub-3940256099942544/1712485313"
            : throw UnsupportedError("Unsupported platform");
  }

  void loadInterstitialAd() {
    AdManagerInterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdManagerAdRequest(),
      adLoadCallback: AdManagerInterstitialAdLoadCallback(
        onAdLoaded: (AdManagerInterstitialAd ad) {
          _interstitialAd = ad;
          log('Interstitial ad loaded');
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (AdManagerInterstitialAd ad) {
          ad.dispose();
          loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (AdManagerInterstitialAd ad, AdError error) {
          ad.dispose();
          log('Interstitial ad failed to show: $error');
        },
      );
    } else {
      log('Interstitial ad is not ready yet.');
    }
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAd = ad;
          log('Rewarded ad loaded');
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('Rewarded ad failed to load: $error');

          /// Optionally retry loading after some delay
          Future.delayed(const Duration(seconds: 5), loadRewardedAd);
        },
      ),
    );
  }

  void showRewardedAd(Function onUserEarnedReward) {
    if (_rewardedAd != null) {
      _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        onUserEarnedReward();
      });
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          ad.dispose();
          loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          ad.dispose();
          log('Rewarded ad failed to show: $error');
        },
      );
    } else {
      log('Rewarded ad is not ready yet.');
    }
  }

  void dispose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }

  ///Facebook Ads
  ///
  String facebookInterstitialPlacementId = "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617";
  String facebookRewardedPlacementId = "";
  String facebookBannerPlacementId = "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047";
  String facebookNativePlacementId = "IMG_16_9_APP_INSTALL#2312433698835503_2964952163583650";
  String facebookNativeBannerPlacementId = "IMG_16_9_APP_INSTALL#2312433698835503_2964953543583512";

  bool _isFBInterstitialAdLoaded = false;
  bool _isFBRewardedAdLoaded = false;
  bool _isFBInterstitialAdLoading = false;

  void loadAds() {
    loadFBInterstitialAd();
  }

  void loadFBInterstitialAd() {
    if (_isFBInterstitialAdLoading) {
      log("Facebook  Interstitial ad is already loading.");
      return;
    }
    _isFBInterstitialAdLoading = true;
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: facebookInterstitialPlacementId,
      listener: (result, value) {
        log("Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.loaded) {
          _isFBInterstitialAdLoaded = true;
          _isFBInterstitialAdLoading = false;
        } else if (result == InterstitialAdResult.error) {
          log("Error loading interstitial ad: $value");
          _isFBInterstitialAdLoading = false;

          Future.delayed(const Duration(seconds: 10), loadFBInterstitialAd);
        }
        if (result == InterstitialAdResult.dismissed && value["invalidated"] == true) {
          _isFBInterstitialAdLoaded = false;
          Future.delayed(const Duration(seconds: 5), loadFBInterstitialAd);
        }
      },
    );
  }

  void showFBInterstitialAd() {
    if (_isFBInterstitialAdLoaded) {
      FacebookInterstitialAd.showInterstitialAd();
      _isFBInterstitialAdLoaded = false;
    } else {
      log("Facebook Interstitial Ad not yet loaded!");
      loadFBInterstitialAd();
    }
  }

  // ignore: unused_element
  void _loadFBRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: facebookRewardedPlacementId,
      listener: (result, value) {
        if (kDebugMode) {
          print("Rewarded Ad: $result --> $value");
        }
        if (result == RewardedVideoAdResult.loaded) {
          _isFBRewardedAdLoaded = true;
        }
        if (result == RewardedVideoAdResult.videoComplete) {}

        if (result == RewardedVideoAdResult.videoClosed && value["invalidated"] == true) {
          _isFBRewardedAdLoaded = false;
          _loadFBRewardedVideoAd();
        }
      },
    );
  }

  void showFBRewardedAd() {
    if (_isFBRewardedAdLoaded) {
      FacebookRewardedVideoAd.showRewardedVideoAd();
    } else {
      log("Rewarded Ad not yet loaded!");
    }
  }

  Widget showFacebookBannerAd() {
    return FacebookBannerAd(
      placementId: facebookBannerPlacementId,
      bannerSize: BannerSize.standard,
      listener: (result, value) {
        log("Banner Ad: $result -->  $value");
      },
      keepAlive: true,
    );
  }
}
