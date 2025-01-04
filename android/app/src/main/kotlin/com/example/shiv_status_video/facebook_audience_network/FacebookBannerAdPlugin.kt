package com.example.shiv_status_video.facebook_audience_network

import android.content.Context as AndroidContext
import android.view.View
import com.facebook.ads.Ad
import com.facebook.ads.AdError
import com.facebook.ads.AdListener
import com.facebook.ads.AdSize
import com.facebook.ads.AdView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class FacebookBannerAdPlugin(private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: AndroidContext, id: Int, args: Any?): PlatformView {
        return FacebookBannerAdView(context, id, args as HashMap<*, *>, messenger)
    }
}

class FacebookBannerAdView(
    context: AndroidContext,
    id: Int,
    private val  args: HashMap<*, *>,
    messenger: BinaryMessenger
) : PlatformView, AdListener {

    private val adView: AdView = AdView(context, args["id"] as String, getBannerSize(args))
    private val channel: MethodChannel =
        MethodChannel(messenger, "${FacebookConstants.BANNER_AD_CHANNEL}_$id")

    init {
        val loadAdConfig = adView.buildLoadAdConfig().withAdListener(this).build()
        adView.loadAd(loadAdConfig)
    }

    private fun getBannerSize(args: HashMap<*, *>): AdSize {
        val height = args["height"] as Int
        return when {
            height >= 250 -> AdSize.RECTANGLE_HEIGHT_250
            height >= 90 -> AdSize.BANNER_HEIGHT_90
            else -> AdSize.BANNER_HEIGHT_50
        }
    }

    override fun getView(): View {
        return adView
    }

    override fun dispose() {
        adView.destroy() // Clean up the AdView to prevent memory leaks
    }

    override fun onError(ad: Ad, adError: AdError) {
        val args = HashMap<String, Any>().apply {
            put("placement_id", ad.placementId)
            put("invalidated", ad.isAdInvalidated)
            put("error_code", adError.errorCode)
            put("error_message", adError.errorMessage)
        }
        channel.invokeMethod(FacebookConstants.ERROR_METHOD, args)
    }

    override fun onAdLoaded(ad: Ad) {
        val args = HashMap<String, Any>().apply {
            put("placement_id", ad.placementId)
            put("invalidated", ad.isAdInvalidated)
        }
        channel.invokeMethod(FacebookConstants.LOADED_METHOD, args)
    }

    override fun onAdClicked(ad: Ad) {
        val args = HashMap<String, Any>().apply {
            put("placement_id", ad.placementId)
            put("invalidated", ad.isAdInvalidated)
        }
        channel.invokeMethod(FacebookConstants.CLICKED_METHOD, args)
    }

    override fun onLoggingImpression(ad: Ad) {
        val args = HashMap<String, Any>().apply {
            put("placement_id", ad.placementId)
            put("invalidated", ad.isAdInvalidated)
        }
        channel.invokeMethod(FacebookConstants.LOGGING_IMPRESSION_METHOD, args)
    }
}
