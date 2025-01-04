import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shiv_status_video/remote/api/api_service.dart';
import 'package:shiv_status_video/remote/api/api_urls.dart';
import 'package:shiv_status_video/remote/model/get_reels_model.dart';
import 'package:shiv_status_video/utils/common.dart';

class ReelsController extends ChangeNotifier {
  late var _reelsData = GetReelsResponse();
  final reelsList = <GetReelsData>[];

  bool isMuted = false;
  late var currentPage = 1;
  bool _isLoading = false;
  var currentIndex = 0;

  ReelsController() {
    Common.initializeUserId();
    fetchReelFromPage();
  }

  Future<void> fetchReelFromPage({int? page}) async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      var url = Common.getRandomReelsUrl(page ?? currentPage, categoryId: "3");
      // var url = Common.getRandomReelsUrl(page ?? currentPage, categoryId: CategoriesIdData.selectedCategoryId!);
      log('reels id ========================= $url');
      var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);

      if (response is Map<String, dynamic>) {
        GetReelsResponse reelsResponse = GetReelsResponse.fromJson(response);
        debugPrint(reelsResponse.data!.data.toString());
        reelsList.addAll(reelsResponse.data!.data!);
        _reelsData = reelsResponse;
        currentPage = _reelsData.data!.currentPage!;
      } else {
        debugPrint('Invalid response format.');
      }
    } catch (e) {
      debugPrint('Error fetching reels data: $e');
    } finally {
      Common.fetchDelay();
      _isLoading = false;
    }
    notifyListeners();
  }

  void loadMoreReels() {
    var totalPages = 1;

    totalPages = _reelsData.data!.lastPage!;
    int perPage = _reelsData.data!.perPage!;

    /// fetch page according reel showing
    /// user pageNation with encapsulated
    // Call CustomCommonUtility.loadMoreReels with the required parameters
    Common.loadMoreReels(
      currentPage: currentPage,
      totalPages: totalPages,
      perPage: perPage,
      fetchReelCategoryFromPage: () async {
        await fetchReelFromPage(page: currentPage + 1);
      },
      pageNationList: reelsList,
    );
    // notifyListeners();
  }

}
