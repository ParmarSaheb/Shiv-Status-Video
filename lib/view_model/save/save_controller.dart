import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shiv_status_video/enumeration/image_format.dart';
import 'package:shiv_status_video/remote/api/api_service.dart';
import 'package:shiv_status_video/remote/api/api_urls.dart';
import 'package:shiv_status_video/remote/api/request_params_api.dart';
import 'package:shiv_status_video/remote/model/get_like_photos_data.dart';
import 'package:shiv_status_video/remote/model/get_like_videos_data.dart';
import 'package:shiv_status_video/services/video_thumbnail.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/view/reels/image_video_extension.dart';

class SaveController extends ChangeNotifier {
  GetLikeVideosResponse getLikeVideosResponseData = GetLikeVideosResponse();
  GetLikePhotosResponse getLikePhotosResponseData = GetLikePhotosResponse();
  List<GetLikeVideosData> getLikeVideosData = <GetLikeVideosData>[];
  List<GetLikePhotosData> getLikePhotosData = <GetLikePhotosData>[];
  List<String> downloadedImageList = <String>[];
  List<String> downloadedVideoList = <String>[];
  List<String> thumbnailImageList = <String>[];
  List<GetLikeVideosData> likedVideos = [];
  List<GetLikePhotosData> likedPhotos = [];

  final int currentPage = 1;
  final int totalPages = 1;
  bool isLoading = true;
  int currentIndexPhotos = 0;
  int currentIndexVideos = 0;
  late int photosCurrentIndex = 0;
  bool isMuted = false;

  SaveController() {
    _initialize();
  }

  Future<void> _initialize() async {
    Common.initializeUserId();

    await fetchLikePhotos(page: 0);
    await fetchLikeVideos(page: 0);

    getDownloadedVideos(RequestParam.saveVideoDirPath);
  }

  Future<void> fetchLikeVideos({int? page}) async {
    isLoading = true;
    notifyListeners();

    try {
      var url = Common().getLikeVideosUrl(page: page);
      var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);

      // if (response is Map<String, dynamic>) {
      //   GetLikeVideosResponse likeVideosResponse = GetLikeVideosResponse.fromJson(response);
      //
      //   getLikeVideosData.insertAll(0, likeVideosResponse.data!.data!);
      //   // getLikeVideosData = likeVideosResponse.data!.data!
      //   //     .where((video) => video.isLiked == 1)
      //   //     .toList();
      //
      //   getLikeVideosResponseData = likeVideosResponse;
      // }
      if (response is Map<String, dynamic>) {
        GetLikeVideosResponse likeVideosResponse = GetLikeVideosResponse.fromJson(response);
        likedVideos = likeVideosResponse.data!.data!;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('fetchLikeVideos:=> Error fetching like photos data: $e');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchLikePhotos({int? page}) async {
    isLoading = true;
    notifyListeners();

    try {
      var url = Common().getLikePhotosUrl(page: page);

      var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);

      // if (response is Map<String, dynamic>) {
      //   GetLikePhotosResponse likePhotosResponse = GetLikePhotosResponse.fromJson(response);
      //
      //   getLikePhotosData.insertAll(0, likePhotosResponse.data!.data!);
      //
      //   // getLikePhotosData = likePhotosResponse.data!.data!
      //   //     .where((photo) => photo.isLiked == 1)
      //   //     .toList();
      //
      //   getLikePhotosResponseData = likePhotosResponse;
      // }

      if (response is Map<String, dynamic>) {
        GetLikePhotosResponse likePhotosResponse = GetLikePhotosResponse.fromJson(response);
        likedPhotos = likePhotosResponse.data!.data!;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('fetchLikePhotos:=> Error fetching like photos data: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // Future<void> fetchLikePhotos({int? page}) async {
  //   isLoading = true;
  //   notifyListeners();
  //   try {
  //     var url = Common().getLikePhotosUrl(page: page);
  //     var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);
  //
  //     if (response is Map<String, dynamic>) {
  //       GetLikePhotosData likePhotosResponse = GetLikePhotosData.fromJson(response);
  //       if (likePhotosResponse.data != null) {
  //         likedPhotos = likePhotosResponse.data!.likeData!;
  //         // SharedPrefrenceClass().isReelLiked(Common.userId!);
  //         log('likedPhotos is list show of response =========-------======== $likedVideos');
  //         log(' is post liked show fav screen of user id ------ ${Common.userId!}');
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint('Error fetching liked photos: $e');
  //   } finally {
  //     isLoading = false;
  //     notifyListeners();
  //   }
  //
  //
  // }

  Future<void> paginationFetchLikePhotos() async {
    int perPage = getLikePhotosResponseData.data!.perPage!;
    Common.loadMoreReels(
      currentPage: currentPage,
      totalPages: totalPages,
      perPage: perPage,
      fetchReelCategoryFromPage: () async {
        await fetchLikePhotos(page: currentPage + 1);
      },
      pageNationList: getLikePhotosData,
    );
    notifyListeners();
  }

  // Future<void> fetchLikeVideos({int? page}) async {
  //   isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     var url = Common().getLikeVideosUrl(page: page);
  //     var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(url);
  //
  //     if (response is Map<String, dynamic>) {
  //       GetLikeVideosData likeVideosResponse = GetLikeVideosData.fromJson(response);
  //       if (likeVideosResponse.data != null) {
  //         likedVideos = likeVideosResponse.data!.likeVideoData!;
  //         log('likeVideoData =========-------======== $likedVideos');
  //         // SharedPrefrenceClass().isReelLiked(Common.userId!);
  //
  //         log(' is reel liked show fav screen of user id------ ${Common.userId!}');
  //
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint('Error fetching liked videos: $e');
  //   }
  //
  //   isLoading = false;
  //   notifyListeners();
  // }

  Future<void> paginationFetchLikeVideos() async {
    int perPage = getLikeVideosResponseData.data!.perPage!;
    Common.loadMoreReels(
      currentPage: currentPage,
      totalPages: totalPages,
      perPage: perPage,
      fetchReelCategoryFromPage: () async {
        await fetchLikeVideos(page: currentPage + 1);
      },
      pageNationList: getLikeVideosData,
    );
    notifyListeners();
  }

  Future<void> getDownloadedVideos(String dirPath) async {
    try {
      final directory = Directory(dirPath);
      final files = await directory.list().toList();

      downloadedImageList.clear();
      thumbnailImageList.clear();
      downloadedVideoList.clear();
      Set<String> addedVideoPaths = {};
      Set<String> addedImagePaths = {};

      for (final file in files) {
        if (file is File) {
          if (file.isValidVideoType) {
            if (!addedVideoPaths.contains(file.path)) {
              addedVideoPaths.add(file.path);
              downloadedVideoList.add(file.path);

              final thumbnailPath = await getThumbnailPath(file.path);

              thumbnailImageList.add(thumbnailPath);
            }
          } else if (file.isValidImageType) {
            if (!addedImagePaths.contains(file.path)) {
              addedImagePaths.add(file.path);
              final imagePath = await getImagePath(file.path);
              if (imagePath != null) {
                downloadedImageList.add(imagePath);
              }
            }
          }
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error getting downloaded videos: $e');
    }
  }

  Future<String> getThumbnailPath(String videoPath) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final thumbnailDir = Directory(directory.path);

      if (!await thumbnailDir.exists()) {
        await thumbnailDir.create(recursive: true);
      }

      final thumbnailFile =
          File('${thumbnailDir.path}/thumbnail_${videoPath.split('/').last.split('.').first}.jpg');
      await generateThumbnail(videoPath, thumbnailFile.path);
      notifyListeners();

      if (await thumbnailFile.exists()) {
        return thumbnailFile.path;
      } else {
        throw Exception("Thumbnail not created");
      }
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
      return '';
    }
  }

  Future<String?> generateThumbnail(String videoPath, String thumbnailPath) async {
    try {
      final thumbnailFilePath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: thumbnailPath,
        imageFormat: EnumImageFormat.jpeg,
        maxHeight: 600,
        quality: 100,
      );
      if (thumbnailFilePath != null) {
        return thumbnailFilePath;
      } else {
        return thumbnailFilePath;
      }
      // await VideoThumbnail.thumbnailFile(
      //   video: videoPath,
      //   thumbnailPath: thumbnailPath,
      //   imageFormat: ImageFormat.JPEG,
      //   maxHeight: 600,
      //   quality: 100,
      // );
    } catch (e) {
      debugPrint('Error generating thumbnail: $e');
    }
    notifyListeners();
    return null;
  }

  getImagePath(String fileName) async {
    final imagePath = fileName;
    final imageFile = File(imagePath);
    if (await imageFile.exists()) {
      return imagePath;
    } else {
      return null;
    }
  }

}
