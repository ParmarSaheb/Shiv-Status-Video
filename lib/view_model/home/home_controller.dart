import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shiv_status_video/remote/api/api_service.dart';
import 'package:shiv_status_video/remote/api/api_urls.dart';
import 'package:shiv_status_video/remote/api/request_params_api.dart';
import 'package:shiv_status_video/remote/model/get_category_god_model.dart';
import 'package:shiv_status_video/remote/model/get_darshan_video_model.dart';
import 'package:shiv_status_video/remote/model/get_reels_model.dart';
import 'package:shiv_status_video/remote/model/reels_like_unlike.dart';
import 'package:shiv_status_video/repository/shared_prefrence_repository/shared_preferences_repository.dart';
import 'package:shiv_status_video/services/adds/add_new/adds_helper.dart';
import 'package:shiv_status_video/shared_preferences/liked_prefs.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:shiv_status_video/view/custom_view/custom_progress_bar.dart';

class HomeController extends ChangeNotifier {
  final ValueNotifier<double> progressNotifier = ValueNotifier(0.0);

  List<GetReelsData> getReelsListData = <GetReelsData>[];
  List<GetCategoryGod> categoryList = [];
  final List<String> _downloadedFiles = [];
  List<String> get downloadedFiles => _downloadedFiles;
  GetReelsResponse reelsResponseData = GetReelsResponse();
  late var getDarshanVideosResponse = GetDarshanVideosResponse();
  AdHelper adHelper = AdHelper();

  late PageController pageController;
  bool isLoading = false;
  bool isInternetLoading = true;
  late int currentPage = 1; // Pagination
  late int totalPages = 1; // Pagination
  late String _categoryId = ""; // Pagination
  int selectedTabIndex = 0;
  String subCategoryId = "";
  late int photosCurrentIndex = 0;
  int currentIndex = 0;
  bool isLoadingMore = false;
  bool isTabVideoMuted = true;
  bool isMuted = true;
  late Dio dio;
  int likeCount = 0;
  bool isUnLiked = true;
  int _selectedValue = -1;

  int get selectedValue => _selectedValue;

  // Constructor
  HomeController() {
    _initialize();
  }

  Future<void> _initialize() async {
    dio = Dio();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Common.initializeUserId();
      fetchCategoryFromApi();
      pageController = PageController(initialPage: 0);
      adHelper.loadRewardedAd();
      adHelper.loadInterstitialAd();
    });
  }

  Future<void> refreshIndicators() async {
    currentPage = 1;
    getReelsListData.clear();

    await fetchReelCategoryFromPage(page: currentPage, categoryId: _categoryId);
    notifyListeners();
  }

  Future<void> setSelectedTab(int index) async {
    selectedTabIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  ///api fetching category wise image & tab controls
  Future<void> fetchCategoryFromApi() async {
    if (isLoading) return;
    isLoading = true;

    var url = Common.getCategoryEndPoint();
    try {
      var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);
      if (response is Map<String, dynamic>) {
        GetCategoryResponse categoryResponse = GetCategoryResponse.fromJson(response);
        categoryList = categoryResponse.data!;

        _categoryId = categoryList.first.categoryId!;
        int cat = int.parse(_categoryId);
        fetchReelCategoryFromPage(page: currentPage, categoryId: cat);
      }
      log('home view response is -===============-----> $response');
    } catch (e) {
      debugPrint('Error fetching category data: $e');
    } finally {
      Common.fetchDelay();
      isLoading = false;
    }
    notifyListeners();
  }

  ///fetch reel must for use on home screen reel & image controls
  Future<void> fetchReelCategoryFromPage({int? page, categoryId}) async {
    isInternetLoading = true;
    notifyListeners();
    int cat = int.parse(_categoryId);

    try {
      var url = Common.getReelsUrl(page ?? currentPage, categoryId: cat);

      var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);
      // log('reels like response is ================= > $response');

      if (response is Map<String, dynamic>) {
        GetReelsResponse reelsResponse = GetReelsResponse.fromJson(response);
        debugPrint(reelsResponse.data!.data.toString());

        getReelsListData.addAll(reelsResponse.data!.data!);
        currentPage = reelsResponse.data!.currentPage!;
        totalPages = reelsResponse.data!.lastPage!;
        reelsResponseData = reelsResponse;
      }
    } catch (e) {
      debugPrint('Error fetching reels data: $e');
    }finally {
      isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> pageNationReels() async {
    if (isLoading || currentPage >= totalPages) return;
    isLoading = true;
    notifyListeners();

    int perPage = reelsResponseData.data!.perPage!;
    Common.loadMoreReels(
      currentPage: currentPage,
      totalPages: totalPages,
      perPage: perPage,
      fetchReelCategoryFromPage: () async {
        await fetchReelCategoryFromPage(page: currentPage + 1, categoryId: _categoryId);
        // await fetchReelCategoryFromPage(page: currentPage + 1, categoryId: CategoriesIdData.selectedCategoryId);
      },
      pageNationList: getReelsListData,
    );

    currentPage++;
    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleMute() async {
    isMuted = !isMuted;
    notifyListeners();
  }

  Future<void> selectValue(int value) async {
    _selectedValue = value;
    notifyListeners();
  }

  Future<void> toggleIsLikedUnlike(int id, isLiked, void Function(bool)? onPressed) async {
    try {
      Map<String, dynamic> body = isUnLiked
          ? {
              RequestParam.userId: Common.userId,
              RequestParam.id: id,
              RequestParam.unLike: true,
            }
          : {
              RequestParam.userId: Common.userId,
              RequestParam.id: id,
            };

      var response = await ApiServices(ApiBaseUrls.baseUrl).postMultipart(ApiBaseUrls.postLike, body);

      log("respose from liked post : $response");

      if (response is Map<String, dynamic>) {
        LikeUnlikeResponse likeUnlikeResponse = LikeUnlikeResponse.fromJson(response);

        if (likeUnlikeResponse.status == 1) {
          if (isUnLiked) {
            likeCount++;
            await SharedPreferencesRepository().mSaveLikedReel(id);
          } else {
            likeCount--;
            await SharedPreferencesRepository().mRemoveLikedReel(id);
          }
          await SharedPreferencesRepository().mSaveLikeCount(id, likeCount);
          isUnLiked = !isUnLiked;
          onPressed!(true);
        }
      }
    } catch (e) {
      debugPrint('Error toggling like/unlike: $e');
    }
  }

  Future<void> showProgressDialog({
    required CancelToken cancelToken,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ProgressDialog(
          progressNotifier: progressNotifier,
          cancelToken: cancelToken,
        );
      },
    );
  }

  Future<void> downloadAndSaveVideo(
      {required String url,
      required String fileName,
      required bool isShare,
      required bool isWhatsAppShare,
      required bool isDownloadOnly,
      required BuildContext context}) async {
    progressNotifier.value = 0.0;

    CancelToken cancelToken = CancelToken();
    String xStreamFile = Uri.parse(url).pathSegments.last;
    String savePath = isShare || isWhatsAppShare
        ? path.join((await getTemporaryDirectory()).path, xStreamFile)
        : path.join(RequestParam.saveVideoDirPath, xStreamFile);

    if (isDownloadOnly && (_downloadedFiles.contains(savePath) || await File(savePath).exists())) {
      if (context.mounted) Common.showToast(context, StringFile.fileAlreadyDownloaded(context));
      return;
    }

    if (context.mounted) showProgressDialog(cancelToken: cancelToken, context: context);

    try {
      debugPrint("====================== Starting download from $url to $savePath===========");
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            progressNotifier.value = (received / total * 100);
            debugPrint("Download progress: ${progressNotifier.value}%");
          }
        },
        cancelToken: cancelToken,
      );

      // if (isDownloadOnly) {
      //   final result = await ImageGallerySaver.saveFile(savePath);
      //   if (result['isSuccess']) {
      //     if (context.mounted) {
      //       Common.showToast(context, StringFile.videoDownloadedAndSavedSuccessfully(context));
      //     }
      //     _downloadedFiles.add(savePath);
      //     if (context.mounted) {
      //       Provider.of<SaveController>(context, listen: false)
      //           .getDownloadedVideos(RequestParam.saveVideoDirPath);
      //     }
      //   } else {
      //     if (context.mounted) {
      //       Common.showToast(context, StringFile.failedToSaveVideoToGallery(context));
      //     }
      //   }
      //   if (File(savePath).isValidImageType) {
      //     if (context.mounted) {
      //       Common.showToast(context, StringFile.photoDownloadedAndSavedSuccessfully(context));
      //     }
      //   }
      // }

      notifyListeners();
      if (isShare) {
        final vPath = XFile(savePath);
        if (context.mounted) await Share.shareXFiles([vPath], text: StringFile.sendMessage(context));
      } else if (isWhatsAppShare) {
        if (context.mounted) await Common().shareFile(savePath, StringFile.sendMessage(context));
      }
    } catch (e) {
      if (e is DioException) {
        if (CancelToken.isCancel(e)) {
          if (context.mounted) Common.showToast(context, StringFile.downloadCancel(context));
        } else {
          if (context.mounted) Common.showToast(context, StringFile.errorDownloadingFile(context));
        }
      } else {
        if (context.mounted) Common.showToast(context, StringFile.errorDownloadingFile(context));
      }
    } finally {
      progressNotifier.value = 0.0;
      notifyListeners();
      if (context.mounted) Navigator.pop(context);
    }
  }

  Future<void> submitReport(String userId, String postId, String text) async {
    try {
      final response = await ApiServices(ApiBaseUrls.baseUrl).postReport(userId, postId, text);
      if (response is Map<String, dynamic> && response['status'] == 1) {
        debugPrint(
            "======================= Report submitted successfully ================: ${response['message']}");
      }
    } catch (e) {
      debugPrint("Error submitting report: $e");
    }
  }

  Future<void> googleRewardedAd({required Function onAdShown}) async {
    adHelper.showRewardedAd(() => onAdShown());
  }

  Future<void> googleNavigationInterstitialAd({required Function onAdShown})async {
    adHelper.showInterstitialAd();
    onAdShown();
  }

}
