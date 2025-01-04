package com.example.shiv_status_video.facebook_audience_network

import android.content.Context as AndroidContext
import android.graphics.Color
import android.view.View
import android.widget.LinearLayout
import com.facebook.ads.Ad
import com.facebook.ads.AdError
import com.facebook.ads.NativeAd
import com.facebook.ads.NativeAdBase
import com.facebook.ads.NativeAdListener
import com.facebook.ads.NativeAdView
import com.facebook.ads.NativeAdViewAttributes
import com.facebook.ads.NativeBannerAd
import com.facebook.ads.NativeBannerAdView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import android.util.Log
import android.widget.Toast


class FacebookNativeAdPlugin(private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: AndroidContext, id: Int, args: Any?): PlatformView {
        return FacebookNativeAdView(context, id, args as HashMap<*, *>, messenger)
    }
}

class FacebookNativeAdView(
    private val  context: AndroidContext,
    id: Int,
    private val  args: HashMap<*, *>,
    messenger: BinaryMessenger
) : PlatformView, NativeAdListener {

    private val adView: LinearLayout = LinearLayout(context)
    private val channel: MethodChannel =
        MethodChannel(messenger, "${FacebookConstants.NATIVE_AD_CHANNEL}_$id")
    private val nativeAd: NativeAd?
    private val bannerAd: NativeBannerAd?

    init {
        if (args["banner_ad"] as Boolean) {
            bannerAd = NativeBannerAd(context, args["id"] as String).apply {
                buildLoadAdConfig().withAdListener(this@FacebookNativeAdView)
                    .withMediaCacheFlag(NativeAdBase.MediaCacheFlag.ALL)
                    .build().let { loadAd(it) }
            }
            nativeAd = null
        } else {
            nativeAd = NativeAd(context, args["id"] as String).apply {
                buildLoadAdConfig().withAdListener(this@FacebookNativeAdView)
                    .withMediaCacheFlag(NativeAdBase.MediaCacheFlag.ALL)
                    .build().let { loadAd(it) }
            }
            bannerAd = null
        }
    }

    private fun getViewAttributes(context: AndroidContext, args: HashMap<*, *>): NativeAdViewAttributes {
        return NativeAdViewAttributes(context).apply {
            args["bg_color"]?.let {
                try {
                    setBackgroundColor(Color.parseColor(it as String))
                } catch (e: IllegalArgumentException) {
                    setBackgroundColor(Color.WHITE) // Default color
                }
            }
            args["title_color"]?.let { setTitleTextColor(Color.parseColor(it as String)) }
            args["desc_color"]?.let { setDescriptionTextColor(Color.parseColor(it as String)) }
            args["button_color"]?.let { setButtonColor(Color.parseColor(it as String)) }
            args["button_title_color"]?.let { setButtonTextColor(Color.parseColor(it as String)) }
            args["button_border_color"]?.let { setButtonBorderColor(Color.parseColor(it as String)) }
        }
    }

    private fun getBannerSize(args: HashMap<*, *>): NativeBannerAdView.Type {
        return when (args["height"] as Int) {
            50 -> NativeBannerAdView.Type.HEIGHT_50
            100 -> NativeBannerAdView.Type.HEIGHT_100
            120 -> NativeBannerAdView.Type.HEIGHT_120
            else -> NativeBannerAdView.Type.HEIGHT_120
        }
    }

    override fun getView(): View {
        return adView
    }

    override fun dispose() {}

    override fun onError(ad: Ad, adError: AdError) {
        Log.e("NativeAdError", "Error loading ad: ${adError.errorMessage}, Code: ${adError.errorCode}")
        val args = hashMapOf(
            "placement_id" to ad.placementId,
            "invalidated" to ad.isAdInvalidated,
            "error_code" to adError.errorCode,
            "error_message" to adError.errorMessage
        )
        channel.invokeMethod(FacebookConstants.ERROR_METHOD, args)
    }

    override fun onAdLoaded(ad: Ad) {
        val args = hashMapOf(
            "placement_id" to ad.placementId,
            "invalidated" to ad.isAdInvalidated
        )
        channel.invokeMethod(FacebookConstants.LOAD_SUCCESS_METHOD, args)
        adView.postDelayed({ showNativeAd() }, 200)
    }

    private fun showNativeAd() {
        adView.removeAllViews()

        if (args["banner_ad"] as Boolean) {
            adView.addView(
                NativeBannerAdView.render(
                    context,
                    bannerAd,
                    getBannerSize(args),
                    getViewAttributes(context, args)
                )
            )
        } else {
            adView.addView(NativeAdView.render(context, nativeAd, getViewAttributes(context, args)))
        }
        channel.invokeMethod(FacebookConstants.LOADED_METHOD, args)
    }

    override fun onAdClicked(ad: Ad) {
        val args = hashMapOf(
            "placement_id" to ad.placementId,
            "invalidated" to ad.isAdInvalidated
        )
        channel.invokeMethod(FacebookConstants.CLICKED_METHOD, args)
    }

    override fun onLoggingImpression(ad: Ad) {
        val args = hashMapOf(
            "placement_id" to ad.placementId,
            "invalidated" to ad.isAdInvalidated
        )
        channel.invokeMethod(FacebookConstants.LOGGING_IMPRESSION_METHOD, args)
    }

    override fun onMediaDownloaded(ad: Ad) {
        val args = hashMapOf(
            "placement_id" to ad.placementId,
            "invalidated" to ad.isAdInvalidated
        )
        channel.invokeMethod(FacebookConstants.MEDIA_DOWNLOADED_METHOD, args)
    }
}
