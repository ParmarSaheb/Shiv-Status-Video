package com.example.shiv_status_video.facebook_audience_network

import android.app.Activity
import android.content.Context as AndroidContext
import com.facebook.ads.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import android.util.Log

/**
 * FacebookAudienceNetworkPlugin
 **/
class FacebookAudienceNetworkPlugin : FlutterPlugin, MethodChannel.MethodCallHandler,
    ActivityAware {

    private lateinit var channel: MethodChannel
    private lateinit var interstitialAdChannel: MethodChannel
    private lateinit var rewardedAdChannel: MethodChannel
    private var _activity: Activity? = null
    private var _context: AndroidContext? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, FacebookConstants.MAIN_CHANNEL)
        channel.setMethodCallHandler(this)
        _context = flutterPluginBinding.applicationContext

        // Interstitial Ad channel
        interstitialAdChannel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            FacebookConstants.INTERSTITIAL_AD_CHANNEL
        )
        interstitialAdChannel.setMethodCallHandler(
            FacebookInterstitialAdPlugin(
                _context!!,
                interstitialAdChannel
            )
        )

        // Rewarded video Ad channel
        rewardedAdChannel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            FacebookConstants.REWARDED_VIDEO_CHANNEL
        )
        rewardedAdChannel.setMethodCallHandler(
            FacebookRewardedVideoAdPlugin(
                _context!!,
                rewardedAdChannel
            )
        )

        // Register Banner and Native Ad factories
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            FacebookConstants.BANNER_AD_CHANNEL,
            FacebookBannerAdPlugin(flutterPluginBinding.getBinaryMessenger())
        )
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            FacebookConstants.NATIVE_AD_CHANNEL,
            FacebookNativeAdPlugin(flutterPluginBinding.binaryMessenger)
        )
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
        Log.d("FacebookAudienceNetwork", "Method called: ${call.method}")
        if (call.method == FacebookConstants.INIT_METHOD) {
            result.success(init(call.arguments as HashMap<*, *>))
        } else {
            Log.d("FacebookAudienceNetwork", "Method not implemented: ${call.method}")
            result.notImplemented()
        }
    }

    private fun init(initValues: HashMap<*, *>): Boolean {
        val testingId = initValues["testingId"] as? String

        AudienceNetworkAds.initialize(_context?.applicationContext)

        testingId?.let {
            AdSettings.addTestDevice(it)
        }
        return true
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        interstitialAdChannel.setMethodCallHandler(null)
        rewardedAdChannel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        _activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        _activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }
}
