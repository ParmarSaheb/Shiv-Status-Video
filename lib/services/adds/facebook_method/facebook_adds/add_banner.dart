import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiv_status_video/services/adds/facebook_method/facebook_audience_network_constant.dart';

class BannerSize {
  final int width;
  final int height;

  static const BannerSize standard = BannerSize(width: 320, height: 50);
  static const BannerSize large = BannerSize(width: 320, height: 90);
  static const BannerSize mediumRectangle = BannerSize(width: 320, height: 250);

  const BannerSize({this.width = 320, this.height = 50});
}

enum BannerAdResult {
  /// Banner Ad error.
  error,

  /// Banner Ad loaded successfully.
  loaded,

  /// Banner Ad clicked.
  clicked,

  /// Banner Ad impression logged.
  loggingImpression,
}

class FacebookBannerAd extends StatefulWidget {
  /// Replace the default one with your placement ID for the release build.
  final String placementId;

  /// Size of the Banner Ad. Choose from three pre-defined sizes.
  final BannerSize bannerSize;

  /// Banner Ad listener
  final void Function(BannerAdResult, dynamic)? listener;

  /// This defines if the ad view to be kept alive.
  final bool keepAlive;

  /// This widget is used to contain Banner Ads. [listener] is used to monitor
  /// Banner Ad. [BannerAdResult] is passed to the callback function along with
  /// other information based on result such as placement id, error code, error
  /// message, click info etc.
  ///
  /// Information will generally be of type Map with details such as:
  ///
  /// ```dart
  /// {
  ///   'placement\_id': "YOUR\_PLACEMENT\_ID",
  ///   'invalidated': false,
  ///   'error\_code': 2,
  ///   'error\_message': "No internet connection",
  /// }
  /// ```
  const FacebookBannerAd({
    super.key,
    this.placementId = "YOUR_PLACEMENT_ID",
    this.bannerSize = BannerSize.standard,
    this.listener,
    this.keepAlive = false,
  });

  @override
  State<FacebookBannerAd> createState() => _FacebookBannerAdState();
}

class _FacebookBannerAdState extends State<FacebookBannerAd> with AutomaticKeepAliveClientMixin {
  double containerHeight = 0.5;

  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container(
        height: containerHeight,
        color: Colors.transparent,
        child: AndroidView(
          viewType: bannerAdChannel,
          onPlatformViewCreated: _onBannerAdViewCreated,
          creationParams: <String, dynamic>{
            "id": widget.placementId,
            "width": widget.bannerSize.width,
            "height": widget.bannerSize.height,
          },
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return Container(
        height: containerHeight,
        color: Colors.transparent,
        child: SizedBox(
          width: widget.bannerSize.width.toDouble(),
          child: Center(
            child: UiKitView(
              viewType: bannerAdChannel,
              onPlatformViewCreated: _onBannerAdViewCreated,
              creationParams: <String, dynamic>{
                "id": widget.placementId,
                "width": widget.bannerSize.width,
                "height": widget.bannerSize.height,
              },
              creationParamsCodec: const StandardMessageCodec(),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: widget.bannerSize.height <= -1 ? double.infinity : widget.bannerSize.height.toDouble(),
        child: const Center(
          child: Text("Banner Ads for this platform is currently not supported"),
        ),
      );
    }
  }

  void _onBannerAdViewCreated(int id) async {
    final channel = MethodChannel('${bannerAdChannel}_$id');

    channel.setMethodCallHandler((MethodCall call) {
      switch (call.method) {
        case errorMethod:
          if (widget.listener != null) {
            widget.listener!(BannerAdResult.error, call.arguments);
          }
          break;
        case loadedMethod:
          setState(() {
            containerHeight =
                widget.bannerSize.height <= -1 ? double.infinity : widget.bannerSize.height.toDouble();
          });
          if (widget.listener != null) {
            widget.listener!(BannerAdResult.loaded, call.arguments);
          }
          break;
        case clickedMethod:
          if (widget.listener != null) {
            widget.listener!(BannerAdResult.clicked, call.arguments);
          }
          break;
        case loggingImpressionMethod:
          if (widget.listener != null) {
            widget.listener!(BannerAdResult.loggingImpression, call.arguments);
          }
          break;
      }

      return Future<dynamic>.value(true);
    });
  }
}
