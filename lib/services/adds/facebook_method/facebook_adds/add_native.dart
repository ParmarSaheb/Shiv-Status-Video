import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_audience_network_constant.dart';

enum NativeAdType {
  /// Customizable Native Ad.
  nativeAd,

  /// Customizable Native Banner Ad.
  nativeBannerAd,
  //ios Only
  nativeAdHorizontal,
  nativeAdVertical,
}

enum NativeAdResult {
  /// Native Ad error.
  error,

  /// Native Ad loaded successfully.
  loaded,

  /// Native Ad clicked.
  clicked,

  /// Native Ad impression logged.
  loggingImpression,

  /// Native Ad media loaded successfully.
  mediaDownloaded,
}

class NativeBannerAdSize {
  final int? height;

  static const NativeBannerAdSize height_50 = NativeBannerAdSize(height: 50);
  static const NativeBannerAdSize height_100 = NativeBannerAdSize(height: 100);
  static const NativeBannerAdSize height_120 = NativeBannerAdSize(height: 120);

  const NativeBannerAdSize({this.height});
}

class FacebookNativeAd extends StatefulWidget {
  /// Replace the default one with your placement ID for the release build.
  final String placementId;

  /// Native Ad listener.
  final void Function(NativeAdResult, dynamic)? listener;

  /// Choose between [NativeAdType.nativeAd] and
  /// [NativeAdType.nativeBannerAd]
  final NativeAdType adType;

  /// If [adType] is [NativeAdType.nativeBannerAd] you can choose between
  /// three predefined Ad sizes.
  final NativeBannerAdSize bannerAdSize;

  /// Recommended width is between **280-500** for Native Ads. You can use
  /// [double.infinity] as the width to match the parent widget width.
  final double width;

  /// Recommended width is between **250-500** for Native Ads. Native Banner Ad
  /// height is predefined in [bannerAdSize] and cannot be
  /// changed through this parameter.
  final double height;

  /// This defines the background color of the Native Ad.
  final Color? backgroundColor;

  /// This defines the title text color of the Native Ad.
  final Color? titleColor;

  /// This defines the description text color of the Native Ad.
  final Color? descriptionColor;

  /// This defines the button color of the Native Ad.
  final Color? labelColor;

  /// This defines the button color of the Native Ad.
  final Color? buttonColor;

  /// This defines the button text color of the Native Ad.
  final Color? buttonTitleColor;

  /// This defines the button border color of the Native Ad.
  final Color? buttonBorderColor;

  final bool isMediaCover;

  /// This defines if the ad view to be kept alive.
  final bool keepAlive;

  /// This defines if the ad view should be collapsed while loading
  final bool keepExpandedWhileLoading;

  /// Expand animation duration in milliseconds
  final int expandAnimationDuraion;

  /// This widget can be used to display customizable native ads and native
  /// banner ads.
  const FacebookNativeAd({
    super.key,
    this.placementId = "YOUR_PLACEMENT_ID",
    this.listener,
    required this.adType,
    this.bannerAdSize = NativeBannerAdSize.height_50,
    this.width = double.infinity,
    this.height = 250,
    this.backgroundColor,
    this.titleColor,
    this.descriptionColor,
    this.labelColor,
    this.buttonColor,
    this.buttonTitleColor,
    this.buttonBorderColor,
    this.isMediaCover = false,
    this.keepAlive = false,
    this.keepExpandedWhileLoading = true,
    this.expandAnimationDuraion = 0,
  });

  @override
  State<FacebookNativeAd> createState() => _FacebookNativeAdState();
}

class _FacebookNativeAdState extends State<FacebookNativeAd> with AutomaticKeepAliveClientMixin {
  final double containerHeight = Platform.isAndroid ? 1.0 : 0.1;
  bool isAdReady = false;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  String _getChannelRegisterId() {
    String channel = nativeAdChannel;
    if (defaultTargetPlatform == TargetPlatform.iOS && widget.adType == NativeAdType.nativeBannerAd) {
      channel = nativeBannerAdChannel;
    }
    return channel;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = widget.width == double.infinity ? MediaQuery.of(context).size.width : widget.width;
    return AnimatedContainer(
      color: Colors.transparent,
      width: width,
      height: isAdReady || widget.keepExpandedWhileLoading ? widget.height : containerHeight,
      duration: Duration(milliseconds: widget.expandAnimationDuraion),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            top: isAdReady || widget.keepExpandedWhileLoading ? 0 : -(widget.height - containerHeight),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: widget.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: buildPlatformView(width),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlatformView(double width) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        width: width,
        height: widget.adType == NativeAdType.nativeAd ||
                widget.adType == NativeAdType.nativeAdHorizontal ||
                widget.adType == NativeAdType.nativeAdVertical
            ? widget.height
            : widget.bannerAdSize.height!.toDouble(),
        child: AndroidView(
          viewType: nativeAdChannel,
          onPlatformViewCreated: _onNativeAdViewCreated,
          creationParamsCodec: const StandardMessageCodec(),
          creationParams: <String, dynamic>{
            "id": widget.placementId,
            "banner_ad": widget.adType == NativeAdType.nativeBannerAd ? true : false,
            // height param is only for Banner Ads. Native Ad's height is
            // governed by container.
            "height": widget.bannerAdSize.height,
            "bg_color":
                widget.backgroundColor == null ? null : _getHexStringFromColor(widget.backgroundColor!),
            "title_color": widget.titleColor == null ? null : _getHexStringFromColor(widget.titleColor!),
            "desc_color":
                widget.descriptionColor == null ? null : _getHexStringFromColor(widget.descriptionColor!),
            "label_color": widget.labelColor == null ? null : _getHexStringFromColor(widget.labelColor!),
            "button_color": widget.buttonColor == null ? null : _getHexStringFromColor(widget.buttonColor!),
            "button_title_color":
                widget.buttonTitleColor == null ? null : _getHexStringFromColor(widget.buttonTitleColor!),
            "button_border_color":
                widget.buttonBorderColor == null ? null : _getHexStringFromColor(widget.buttonBorderColor!),
          },
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
        width: width,
        height:
            widget.adType == NativeAdType.nativeAd ? widget.height : widget.bannerAdSize.height!.toDouble(),
        child: UiKitView(
          viewType: _getChannelRegisterId(),
          onPlatformViewCreated: _onNativeAdViewCreated,
          creationParamsCodec: const StandardMessageCodec(),
          creationParams: <String, dynamic>{
            "id": widget.placementId,
            "ad_type": widget.adType.index,
            "banner_ad": widget.adType == NativeAdType.nativeBannerAd ? true : false,
            "height":
                widget.adType == NativeAdType.nativeBannerAd ? widget.bannerAdSize.height : widget.height,
            "bg_color":
                widget.backgroundColor == null ? null : _getHexStringFromColor(widget.backgroundColor!),
            "title_color": widget.titleColor == null ? null : _getHexStringFromColor(widget.titleColor!),
            "desc_color":
                widget.descriptionColor == null ? null : _getHexStringFromColor(widget.descriptionColor!),
            "label_color": widget.labelColor == null ? null : _getHexStringFromColor(widget.labelColor!),
            "button_color": widget.buttonColor == null ? null : _getHexStringFromColor(widget.buttonColor!),
            "button_title_color":
                widget.buttonTitleColor == null ? null : _getHexStringFromColor(widget.buttonTitleColor!),
            "button_border_color":
                widget.buttonBorderColor == null ? null : _getHexStringFromColor(widget.buttonBorderColor!),
            "is_media_cover": widget.isMediaCover,
          },
        ),
      );
    } else {
      return SizedBox(
        width: width,
        height: widget.height,
        child: const Text("Native Ads for this platform is currently not supported"),
      );
    }
  }

  String _getHexStringFromColor(Color color) => '#${color.value.toRadixString(16)}';

  void _onNativeAdViewCreated(int id) {
    final channel = MethodChannel('${nativeAdChannel}_$id');

    channel.setMethodCallHandler((MethodCall call) {
      switch (call.method) {
        case errorMethod:
          if (widget.listener != null) {
            widget.listener!(NativeAdResult.error, call.arguments);
          }
          break;
        case loadedMethod:
          if (widget.listener != null) {
            widget.listener!(NativeAdResult.loaded, call.arguments);
          }

          if (!isAdReady) {
            setState(() {
              isAdReady = true;
            });
          }

          /// ISSUE: Changing height on Ad load causes the ad button to not work
          /*setState(() {
            containerHeight = widget.height;
          });*/
          break;
        case loadSuccessMethod:
          if (!mounted) Future<dynamic>.value(true);
          if (!isAdReady) {
            setState(() {
              isAdReady = true;
            });
          }
          break;
        case clickedMethod:
          if (widget.listener != null) {
            widget.listener!(NativeAdResult.clicked, call.arguments);
          }
          break;
        case loggingImpressionMethod:
          if (widget.listener != null) {
            widget.listener!(NativeAdResult.loggingImpression, call.arguments);
          }
          break;
        case mediaDownloadedMethod:
          if (widget.listener != null) {
            widget.listener!(NativeAdResult.mediaDownloaded, call.arguments);
          }
          break;
      }

      return Future<dynamic>.value(true);
    });
  }
}
