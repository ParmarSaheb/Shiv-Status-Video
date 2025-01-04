import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiv_status_video/remote/model/get_like_photos_data.dart';
import 'package:shiv_status_video/remote/model/get_like_videos_data.dart';
import 'package:shiv_status_video/view_model/liked_provider.dart';

enum LikedPrefsKey { likedImageList, likedVideoList }

class LikedPrefs {
  LikedPrefs._();

  static SharedPreferences? _sp;

  static Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  static SharedPreferences? get sp => _sp;

  /// GLOBAL VALUES
  ///
  // static List<String> likedList(LikeType type) => type.isSame(LikeType.image) ? likedImageList : likedVideoList;
  static List<dynamic> likedList(LikeType type) => type.isSame(LikeType.image) ? likedImageList : likedVideoList;
  static List<GetLikePhotosData> get likedImageList => (sp?.getStringList(LikedPrefsKey.likedImageList.name) ?? []).map((e) => GetLikePhotosData.fromJson(jsonDecode(e))).toList();
  static List<GetLikeVideosData> get likedVideoList => (sp?.getStringList(LikedPrefsKey.likedVideoList.name) ?? []).map((e) => GetLikeVideosData.fromJson(jsonDecode(e))).toList();

  ///
  // static Future<void> setLikedListByType(LikeType type, List<String> list) async => type.isSame(LikeType.image) ? setLikedImageList(list) : setLikedVideoList(list);
  static Future<void> setLikedListByType(LikeType type, List<dynamic> list) async => type.isSame(LikeType.image) ? setLikedImageList(list) : setLikedVideoList(list);
  static Future<void> setLikedImageList(dynamic list) async => await sp?.setStringList(LikedPrefsKey.likedImageList.name, list.map((e) => jsonEncode(e)).toList());
  static Future<void> setLikedVideoList(dynamic list) async => await sp?.setStringList(LikedPrefsKey.likedVideoList.name, list.map((e) => jsonEncode(e)).toList());

  ///

}
