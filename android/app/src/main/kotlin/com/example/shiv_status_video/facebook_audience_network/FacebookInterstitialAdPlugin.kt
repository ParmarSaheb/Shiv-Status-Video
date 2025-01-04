package com.example.shiv_status_video.facebook_audience_network

import android.content.Context as AndroidContext
import android.os.Handler
import android.util.Log
import com.facebook.ads.Ad
import com.facebook.ads.AdError
import com.facebook.ads.CacheFlag
import com.facebook.ads.InterstitialAd
import com.facebook.ads.InterstitialAdListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class FacebookInterstitialAdPlugin(private val context: AndroidContext, private val channel: MethodChannel) : MethodChannel.MethodCallHandler, InterstitialAdListener {

    private var interstitialAd: InterstitialAd? = null
    private val delayHandler = Handler()

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            FacebookConstants.SHOW_INTERSTITIAL_METHOD -> result.success(showAd(methodCall.arguments as HashMap<*, *>))
            FacebookConstants.LOAD_INTERSTITIAL_METHOD -> result.success(loadAd(methodCall.arguments as HashMap<*, *>))
            FacebookConstants.DESTROY_INTERSTITIAL_METHOD -> result.success(destroyAd())
            else -> result.notImplemented()
        }
    }

    private fun loadAd(args: HashMap<*, *>): Boolean {
        val placementId = args["id"] as String

        if (interstitialAd == null) {
            interstitialAd = InterstitialAd(context, placementId)
        }
        return try {
            if (interstitialAd?.isAdLoaded == false) {
                val loadAdConfig = interstitialAd!!.buildLoadAdConfig()
                    .withAdListener(this)
                    .withCacheFlags(CacheFlag.ALL)
                    .build()

                interstitialAd!!.loadAd(loadAdConfig)
            }
            true
        } catch (e: Exception) {
            Log.e("InterstitialLoadAdError", "Error loading ad: ${e.message}", e)
            false
        }
    }

    private fun showAd(args: HashMap<*, *>): Boolean {
        val delay = args["delay"] as Int

        if (interstitialAd == null || interstitialAd?.isAdLoaded == false || interstitialAd?.isAdInvalidated == true) {
            return false
        }

        if (delay <= 0) {
            interstitialAd?.let {
                val showAdConfig = it.buildShowAdConfig().build()
                it.show(showAdConfig)
            }
        } else {
            delayHandler.postDelayed({
                interstitialAd?.let {
                    if (it.isAdLoaded && !it.isAdInvalidated) {
                        val showAdConfig = it.buildShowAdConfig().build()
                        it.show(showAdConfig)
                    }
                }
            }, delay.toLong())
        }
        return true
    }

    private fun destroyAd(): Boolean {
        return if (interstitialAd != null) {
            interstitialAd!!.destroy()
            interstitialAd = null
            true
        } else {
            false
        }
    }

    override fun onInterstitialDisplayed(ad: Ad) {
        val args = hashMapOf(
            "placement_id" to ad.placementId,
            "invalidated" to ad.isAdInvalidated
        )
        channel.invokeMethod(FacebookConstants.DISPLAYED_METHOD, args)
    }

    override fun onInterstitialDismissed(ad: Ad) {
        val args = hashMapOf(
            "placement_id" to ad.placementId,
            "invalidated" to ad.isAdInvalidated
        )
        channel.invokeMethod(FacebookConstants.DISMISSED_METHOD, args)
    }

    override fun onError(ad: Ad, adError: AdError) {
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
}
