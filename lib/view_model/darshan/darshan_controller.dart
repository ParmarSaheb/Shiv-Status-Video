import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shiv_status_video/remote/api/api_service.dart';
import 'package:shiv_status_video/remote/api/api_urls.dart';
import 'package:shiv_status_video/remote/model/get_darshan_photo_response.dart';
import 'package:shiv_status_video/remote/model/get_darshan_sub_category.dart';
import 'package:shiv_status_video/remote/model/get_darshan_video_model.dart';
import 'package:shiv_status_video/utils/common.dart';

class DarshanController extends ChangeNotifier {
  List<GetSubCategoryData> subCategoryResponseDataList = <GetSubCategoryData>[];

  GetSubCategoryData getSubCategoryData = GetSubCategoryData();
  final subCategoryDarshanPhotosList = <GetDarshanPhotos>[];
  final subCategoryDarshanVideosList = <GetDarshanVideos>[];
  late var getDarshanPhotoResponse = GetDarshanPhotoResponse();
  late var getDarshanVideosResponse = GetDarshanVideosResponse();

  String subCategoryId = "";
  bool isLoading = false;
  bool isLoadingMore = false;
  late int photosCurrentIndex = 0;

  DarshanController() {
    Common.initializeUserId();
    fetchMahadevSubCategories();
    loadSubCategoryData();
    fetchDarshanPhotosSubCategoryFromApi(subCategories: '3');
    // fetchDarshanVideosSubCategoryFromApi(subCategories: '3');
  }

  Future<void> fetchMahadevSubCategories() async {
    subCategoryResponseDataList.clear();
    isLoading = true;
    notifyListeners();

    try {
      var url = Common.getSubcategoryUrl(categoryId: 5, languageId: 1);
      // var url = Common.getSubcategoryUrl(categoryId: CategoriesIdData.selectedCategoryId);

      var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);
      if (response is Map<String, dynamic>) {
        GetSubCategoriesResponse categoryResponse = GetSubCategoriesResponse.fromJson(response);
        final data = categoryResponse.data;
        if (data != null) {
          subCategoryResponseDataList.addAll(data);
          subCategoryId = subCategoryResponseDataList.first.categoryId!;
        }
      }

      log(' language id darshan images is --------- ${getSubCategoryData.languageId}');
      log(' language id darshan images is --------- ${subCategoryResponseDataList.last.languageId}');
      // var url = Common.getSubcategoryUrl(categoryId: 5);
      // var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);
      // if (response is Map<String, dynamic>) {
      //   GetSubCategoriesResponse categoryResponse = GetSubCategoriesResponse
      //       .fromJson(response);
      //   subCategoryResponseDataList = categoryResponse.data ?? [];
      // }
    } catch (e) {
      debugPrint('Error fetching darshan subcategories: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchDarshanPhotosSubCategoryFromApi({required String subCategories, page}) async {
    if (isLoading) return;
    isLoading = true;
    // notifyListeners();

    var cat = int.parse(subCategories);

    try {
      var url = Common.getDarshanPhotoUrl(
        subCategories: cat,
        page: page,
      );
      var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);
      if (response is Map<String, dynamic>) {
        GetDarshanPhotoResponse categoryResponse = GetDarshanPhotoResponse.fromJson(response);
        getDarshanPhotoResponse = categoryResponse;
        if (categoryResponse.data != null) {
          subCategoryDarshanPhotosList.addAll(categoryResponse.data!.data!);
        }
      }
    } catch (e, stack) {
      debugPrint('Error fetching darshan categories: $e ');
      debugPrintStack(stackTrace: stack);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchDarshanVideosSubCategoryFromApi({required String subCategories, page}) async {
    if (isLoading) return;
    isLoading = true;

    var cat = int.parse(subCategories);

    try {
      var url = Common.getDarshanVideosUrl(
        subCategories: cat,
        page: page,
      );
      debugPrint(url);
      var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);
      // var response = await ApiService(ApiBaseUrls.baseUrl).fetchMultipartData(url);

      if (response is Map<String, dynamic>) {
        GetDarshanVideosResponse categoryResponse = GetDarshanVideosResponse.fromJson(response);

        getDarshanVideosResponse = categoryResponse;
        if (categoryResponse.data != null) {
          subCategoryDarshanVideosList.addAll(getDarshanVideosResponse.data!.data!);
        }
      } else {
        debugPrint('Invalid response format.');
      }
    } catch (e, stack) {
      debugPrint('Error fetching darshan categories: $e');
      debugPrintStack(stackTrace: stack);
    }
    await Future.delayed(const Duration(seconds: 3));
    isLoading = false;
    notifyListeners();
  }

  Future<void> subCategoryDarshanPhotosVideosListClear() async {
    subCategoryDarshanVideosList.clear();
    subCategoryDarshanPhotosList.clear();
  }

  Future<void> loadMorePageNationPhotos() async {
    int currentPage = 1;
    int totalPages = 1;
    int perPage = 1;
    currentPage = getDarshanPhotoResponse.data!.currentPage!;

    totalPages = getDarshanPhotoResponse.data!.total!;
    perPage = getDarshanPhotoResponse.data!.perPage!;

    debugPrint(currentPage.toString());
    debugPrint(totalPages.toString());
    debugPrint(perPage.toString());

    /// fetch page according reel showing
    /// user pageNation with encapsulated
    Common.loadMoreReels(
      currentPage: currentPage,
      totalPages: totalPages,
      perPage: perPage,
      fetchReelCategoryFromPage: () async {
        await fetchDarshanPhotosSubCategoryFromApi(page: currentPage += 1, subCategories: subCategoryId);
        debugPrint(currentPage.toString());
      },
      pageNationList: subCategoryDarshanPhotosList,
    );
    notifyListeners();
  }

  Future<void> loadSubCategoryData() async {
    if (subCategoryResponseDataList.isNotEmpty) {
      subCategoryId = subCategoryResponseDataList.first.categoryId!;

      await fetchDarshanPhotosSubCategoryFromApi(subCategories: subCategoryId);
    }
  }

  Future<void> loadMorePageNationVideos() async {
    int currentPage = 1;
    int totalPages = 1;
    int perPage = 1;
    currentPage = getDarshanVideosResponse.data!.currentPage!;

    totalPages = getDarshanVideosResponse.data!.total!;
    perPage = getDarshanVideosResponse.data!.perPage!;

    debugPrint(currentPage.toString());
    debugPrint(totalPages.toString());
    debugPrint(perPage.toString());

    /// fetch page according reel showing
    /// user pageNation with encapsulated

    Common.loadMoreReels(
      currentPage: currentPage,
      totalPages: totalPages,
      perPage: perPage,
      fetchReelCategoryFromPage: () async {
        await fetchDarshanVideosSubCategoryFromApi(
            page: currentPage + 1, subCategories: subCategoryId.toString());
        debugPrint(currentPage.toString());
      },
      pageNationList: subCategoryDarshanVideosList,
    );
  }

// Future<void> darshanPhotoResponse() async {
//   try {
//     final headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//
//     var url = Uri.parse('https://dailydarshan.online/api/get-sub-categories?&language=1?&category=5');
//     var response = await http.get(url, headers: headers);
//
//     if (response.statusCode == 200) {
//       var jsonResponse = json.decode(response.body);
//       log(' Darshan main response ================ -------------- ================ $jsonResponse');
//     } else {
//       log('Error: ${response.statusCode} - ${response.body}');
//     }
//   } catch (e) {
//     log('Error: $e');
//   }
// }
//
// Future<void> darshanPhotoLikeDataResponse() async {
//   try {
//     final headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//
//     var url = Uri.parse('https://dailydarshan.online/api/get-darshan-photos?language=1&user_id=le523nuwb7&sub_categories=9&page=0');
//     var response = await http.get(url, headers: headers);
//
//     if (response.statusCode == 200) {
//       var jsonResponse = json.decode(response.body);
//       log(' Darshan photo like response ================ -------------- ================ $jsonResponse');
//     } else {
//       log('Error: ${response.statusCode} - ${response.body}');
//     }
//   } catch (e) {
//     log('Error: $e');
//   }
// }
//
// Future<void> savePhotoLikeDataResponse() async {
//   try {
//     final headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//
//     var url = Uri.parse('https://dailydarshan.online/api/get-like-photos?user_id=le523nuwb7&page=0');
//     var response = await http.get(url, headers: headers);
//
//     if (response.statusCode == 200) {
//       var jsonResponse = json.decode(response.body);
//       log(' save photo like response ================ -------------- ================ $jsonResponse');
//     } else {
//       log('Error: ${response.statusCode} - ${response.body}');
//     }
//   } catch (e) {
//     log('Error: $e');
//   }
// }
}
