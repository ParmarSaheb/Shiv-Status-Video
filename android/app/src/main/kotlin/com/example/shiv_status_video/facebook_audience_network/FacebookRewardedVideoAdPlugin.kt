package com.example.shiv_status_video.facebook_audience_network

import android.content.Context as AndroidContext
import android.os.Handler
import android.util.Log
import com.facebook.ads.Ad
import com.facebook.ads.AdError
import com.facebook.ads.RewardedVideoAd
import com.facebook.ads.RewardedVideoAdListener
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.widget.Toast

class FacebookRewardedVideoAdPlugin(
    private val context: AndroidContext,
    private val channel: MethodChannel
) : MethodChannel.MethodCallHandler, RewardedVideoAdListener {

    private var rewardedVideoAd: RewardedVideoAd? = null
    private val delayHandler = Handler()

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            FacebookConstants.SHOW_REWARDED_VIDEO_METHOD -> result.success(showAd(methodCall.arguments as HashMap<*, *>))
            FacebookConstants.LOAD_REWARDED_VIDEO_METHOD -> result.success(loadAd(methodCall.arguments as HashMap<*, *>))
            FacebookConstants.DESTROY_REWARDED_VIDEO_METHOD -> result.success(destroyAd())
            else -> result.notImplemented()
        }
    }

    private fun loadAd(args: HashMap<*, *>): Boolean {
        val placementId = args["id"] as String

        if (rewardedVideoAd == null) {
            rewardedVideoAd = RewardedVideoAd(context, placementId)
        }

        return try {
            if (rewardedVideoAd?.isAdLoaded == false) {
                val loadAdConfig = rewardedVideoAd!!.buildLoadAdConfig()
                    .withAdListener(this)
                    .build()
                rewardedVideoAd!!.loadAd(loadAdConfig)
            }
            true
        } catch (e: Exception) {
            Log.e("RewardedVideoAdError", "Failed to load ad: ${e.message ?: "Unknown error"}")
            Toast.makeText(context, "Failed to load ad", Toast.LENGTH_SHORT).show()
            false
        }
    }

    private fun showAd(args: HashMap<*, *>): Boolean {
        val delay = args["delay"] as Int

        if (rewardedVideoAd == null || !rewardedVideoAd!!.isAdLoaded || rewardedVideoAd!!.isAdInvalidated) {
            Log.w("RewardedVideoAd", "Ad is not loaded or invalidated.")
            return false
        }

        if (delay <= 0) {
            val showAdConfig = rewardedVideoAd!!.buildShowAdConfig().build()
            rewardedVideoAd!!.show(showAdConfig)
        } else {
            delayHandler.postDelayed({
                if (rewardedVideoAd == null || !rewardedVideoAd!!.isAdLoaded || rewardedVideoAd!!.isAdInvalidated) return@postDelayed
                val showAdConfig = rewardedVideoAd!!.buildShowAdConfig().build()
                rewardedVideoAd!!.show(showAdConfig)
            }, delay.toLong())
        }
        return true
    }

    private fun destroyAd(): Boolean {
        rewardedVideoAd?.destroy()
        rewardedVideoAd = null
        return true
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

    override fun onRewardedVideoCompleted() {
        channel.invokeMethod(FacebookConstants.REWARDED_VIDEO_COMPLETE_METHOD, true)
    }

    override fun onRewardedVideoClosed() {
        channel.invokeMethod(FacebookConstants.REWARDED_VIDEO_CLOSED_METHOD, true)
    }
}
