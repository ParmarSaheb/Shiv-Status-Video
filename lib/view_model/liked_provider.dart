import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shiv_status_video/main.dart';
import 'package:shiv_status_video/remote/model/get_like_photos_data.dart';
import 'package:shiv_status_video/remote/model/get_like_videos_data.dart';
import 'package:shiv_status_video/shared_preferences/liked_prefs.dart';
import 'package:shiv_status_video/utils/common.dart';

enum LikeType {
  video,
  image,
  ;

  bool isSame(LikeType type) => type == this;
}

class LikedProvider extends ChangeNotifier {
  /// FAVOURITES
  ///

  List<GetLikeVideosData> get favVideoList => _favVideoList;
  List<GetLikeVideosData> _favVideoList = [];

  List<GetLikePhotosData> get favImageList => _favImageList;
  List<GetLikePhotosData> _favImageList = [];

  bool isFavourite(LikeType type, String? id) {
    if (id == null) return false;
    if (type.isSame(LikeType.image))
      return favImageList.map((e) => e.id).contains(id);
    else
      return favVideoList.map((e) => e.id).contains(id);
  }

  Future<bool> getFavourites(LikeType type) async {
    try {
      if (type.isSame(LikeType.image)) {
        _favImageList = await LikedPrefs.likedImageList;
      } else {
        _favVideoList = await LikedPrefs.likedVideoList;
      }
      notifyListeners();
      return true;
    } catch (e) {
      log("error : " + e.toString());
      return false;
    }
  }

  Future<bool> setToFavourite(LikeType type, dynamic? data) async {
    if (data == null) return false;
    try {
      final favList = LikedPrefs.likedList(type);
      if (favList.map((e) => e.id).contains(data.id)) {
        favList.removeWhere((element) => element.id == data.id);
        try {
          Common.showToast(MyApp.navigatorKey.currentContext!, "Removed from favourites.!");
        } catch (_) {}
        await getFavourites(type);
      } else {
        favList.add(jsonEncode(data));
        try {
          Common.showToast(MyApp.navigatorKey.currentContext!, "Added to favourites.!");
        } catch (_) {}
      }
      await LikedPrefs.setLikedListByType(type, favList);
      await getFavourites(type);
      notifyListeners();
      return true;
    } catch (e) {
      log("error : " + e.toString());
      return false;
    }
  }

  Future<bool> removeFromFavourite(LikeType type, String id) async {
    try {
      final favList = await LikedPrefs.likedList(type);
      favList.removeWhere((element) => element.id == id);
      await LikedPrefs.setLikedListByType(type, favList);
      await getFavourites(type);
      return true;
    } catch (e) {
      log("error : " + e.toString());
      return false;
    } finally {
      notifyListeners();
    }
  }
}
