import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiv_status_video/shared_preferences/shared_preferences_key/shared_preference_key.dart';

class SharedPreferenceManager {
  late SharedPreferences preferences;

  Future<void> mSaveUserId(String userId) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setString(SharedPreferenceKey.getUserId, userId);
  }

  Future<String?> mLoadUserId() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(SharedPreferenceKey.getUserId);
  }

  Future<void> mSaveLanguage(String languageCode) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setString(SharedPreferenceKey.selectedLanguage, languageCode);
  }

  Future<String?> mGetLanguage() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getString(SharedPreferenceKey.selectedLanguage);
  }

  Future<void> mSaveLikedReel(int reelId) async {
    preferences = await SharedPreferences.getInstance();
    List<String> likedReels = preferences.getStringList(SharedPreferenceKey.likedReelsKey) ?? [];
    likedReels.add(reelId.toString());
    await preferences.setStringList(SharedPreferenceKey.likedReelsKey, likedReels);
  }

  Future<void> mRemoveLikedReel(int reelId) async {
    preferences = await SharedPreferences.getInstance();
    List<String> likedReels = preferences.getStringList(SharedPreferenceKey.likedReelsKey) ?? [];
    likedReels.remove(reelId.toString());
    await preferences.setStringList(SharedPreferenceKey.likedReelsKey, likedReels);
  }

  Future<bool> mIsReelLiked(int reelId) async {
    preferences = await SharedPreferences.getInstance();
    List<String> likedReels = preferences.getStringList(SharedPreferenceKey.likedReelsKey) ?? [];
    return likedReels.contains(reelId.toString());
  }

  Future<void> mSaveLikeCount(int reelId, int likeCount) async {
    preferences = await SharedPreferences.getInstance();
    await preferences.setInt('likeCount_$reelId', likeCount);
  }

  Future<int> mGetLikeCount(int reelId) async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getInt('likeCount_$reelId') ?? 0;
  }

}
