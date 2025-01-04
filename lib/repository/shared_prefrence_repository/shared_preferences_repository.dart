import 'package:shiv_status_video/shared_preferences/shared_preference_class/shared_preferences_class.dart';

class SharedPreferencesRepository {
  final sharedPreference = SharedPreferenceManager();

  Future<void> mSaveUserId(String userId) async {
    await sharedPreference.mSaveUserId(userId);
  }

  Future<String?> mLoadUserId() async {
    return await sharedPreference.mLoadUserId();
  }

  Future<void> mSaveLanguage(String languageCode) async {
    await sharedPreference.mSaveLanguage(languageCode);
  }

  Future<String?> mGetLanguage() async {
   return await sharedPreference.mGetLanguage();
  }

  Future<void> mSaveLikedReel(int reelId) async {
    await sharedPreference.mSaveLikedReel(reelId);
  }

  Future<void> mRemoveLikedReel(int reelId) async {
    await sharedPreference.mRemoveLikedReel(reelId);
  }

  Future<bool> mIsReelLiked(int reelId) async {
    return await sharedPreference.mIsReelLiked(reelId);
  }

  Future<void> mSaveLikeCount(int reelId,int likeCount) async {
    await sharedPreference.mSaveLikeCount(reelId,likeCount);
  }

  Future<int> mGetLikeCount(int reelId) async {
    return await sharedPreference.mGetLikeCount(reelId);
  }

}
