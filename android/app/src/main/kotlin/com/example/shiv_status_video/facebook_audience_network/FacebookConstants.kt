package com.example.shiv_status_video.facebook_audience_network

internal object FacebookConstants {
    const val MAIN_CHANNEL: String = "fb.audience.network.io"
    const val BANNER_AD_CHANNEL: String = MAIN_CHANNEL + "/bannerAd"
    const val INTERSTITIAL_AD_CHANNEL: String = MAIN_CHANNEL + "/interstitialAd"
    const val NATIVE_AD_CHANNEL: String = MAIN_CHANNEL + "/nativeAd"
    const val REWARDED_VIDEO_CHANNEL: String = MAIN_CHANNEL + "/rewardedAd"

    const val INIT_METHOD: String = "init"
    const val SHOW_INTERSTITIAL_METHOD: String = "showInterstitialAd"
    const val LOAD_INTERSTITIAL_METHOD: String = "loadInterstitialAd"
    const val DESTROY_INTERSTITIAL_METHOD: String = "destroyInterstitialAd"

    const val SHOW_REWARDED_VIDEO_METHOD: String = "showRewardedAd"
    const val LOAD_REWARDED_VIDEO_METHOD: String = "loadRewardedAd"
    const val DESTROY_REWARDED_VIDEO_METHOD: String = "destroyRewardedAd"

    const val DISPLAYED_METHOD: String = "displayed"
    const val DISMISSED_METHOD: String = "dismissed"
    const val ERROR_METHOD: String = "error"
    const val LOADED_METHOD: String = "loaded"
    const val CLICKED_METHOD: String = "clicked"
    const val LOGGING_IMPRESSION_METHOD: String = "logging_impression"
    const val REWARDED_VIDEO_COMPLETE_METHOD: String = "rewarded_complete"
    const val REWARDED_VIDEO_CLOSED_METHOD: String = "rewarded_closed"

    const val MEDIA_DOWNLOADED_METHOD: String = "media_downloaded"
    const val LOAD_SUCCESS_METHOD: String = "load_success"
}
