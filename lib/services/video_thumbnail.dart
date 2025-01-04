import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shiv_status_video/enumeration/image_format.dart';
import 'package:shiv_status_video/remote/api/request_params_api.dart';

class VideoThumbnail {
  static const MethodChannel _thumbnailChannel = MethodChannel(RequestParam.generateThumbnail);

  static Future<String?> thumbnailFile(
      {required String video,
        Map<String, String>? headers,
        String? thumbnailPath,
        EnumImageFormat imageFormat = EnumImageFormat.png,
        int maxHeight = 0,
        int maxWidth = 0,
        int timeMs = 0,
        int quality = 10}) async {
    assert(video.isNotEmpty);
    if (video.isEmpty) return null;
    final reqMap = <String, dynamic>{
      'video': video,
      'headers': headers,
      'path': thumbnailPath,
      'format': imageFormat.index,
      'maxh': maxHeight,
      'maxw': maxWidth,
      'timeMs': timeMs,
      'quality': quality
    };
    try {
      return await _thumbnailChannel.invokeMethod('file', reqMap);
    } catch (e) {
      debugPrint('Error generating thumbnail file VideoThumbnail: $e');
      return null;
    }
  }

  static Future<Uint8List?> thumbnailData({
    required String video,
    Map<String, String>? headers,
    EnumImageFormat imageFormat = EnumImageFormat.png,
    int maxHeight = 0,
    int maxWidth = 0,
    int timeMs = 0,
    int quality = 10,
  }) async {
    assert(video.isNotEmpty);
    final reqMap = <String, dynamic>{
      'video': video,
      'headers': headers,
      'format': imageFormat.index,
      'maxh': maxHeight,
      'maxw': maxWidth,
      'timeMs': timeMs,
      'quality': quality,
    };
    return await _thumbnailChannel.invokeMethod('data', reqMap);
  }
}
