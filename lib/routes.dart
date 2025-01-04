import 'package:flutter/material.dart';
import 'package:shiv_status_video/view/darshan/daily_darshan_sub_category.dart';
import 'package:shiv_status_video/view/darshan/darshan_category_photos_reel.dart';
import 'package:shiv_status_video/view/darshan/darshan_view.dart';
import 'package:shiv_status_video/view/home/home_view.dart';
import 'package:shiv_status_video/view/language/language_view.dart';
import 'package:shiv_status_video/view/reels/reels_view.dart';
import 'package:shiv_status_video/view/save/download/download_photo_reels_view.dart';
import 'package:shiv_status_video/view/save/download/download_see_all_photos_videos_view.dart';
import 'package:shiv_status_video/view/save/download/download_video_reels_view.dart';
import 'package:shiv_status_video/view/save/favourites/favourite_see_all_video_view.dart';
import 'package:shiv_status_video/view/save/favourites/favourites_photos_reels.dart';
import 'package:shiv_status_video/view/save/favourites/favourites_see_all_photos_view.dart';
import 'package:shiv_status_video/view/save/favourites/favourites_video_reels_view.dart';
import 'package:shiv_status_video/view/splash/splash_view.dart';
import 'view/bottom_navigation_bar/bottom_navigation_bar_view.dart';
import 'view/custom_view/combine_video_reels.dart';
import 'view/save/save_view.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String languageView = '/LanguageView';
  static const String bottomNavigationBarView = '/BottomNavigationBarView';
  static const String homeView = '/HomeView';
  static const String darshanView = '/DarshanView';
  static const String reelsView = '/ReelsView';
  static const String saveView = '/SaveView';
  static const String darshanCategoryPhotosReel = '/DarshanCategoryPhotosReel';
  static const String combinedCategoryVideoReelView = '/CombinedCategoryVideoReel';
  static const String dailyDarshanSubCategoryView = '/DailyDarshanSubCategory';
  static const String favouritesSeeAllPhotosView = '/FavouritesSeeAllPhotosView';
  static const String favouriteSeeAllVideoView = '/FavouriteSeeAllVideoView';
  static const String downloadPhotoReelsView = '/DownloadPhotoReelsView';
  static const String downloadVideoReelsView = '/DownloadVideoReelsView';
  static const String downloadSeeAllPhotosVideosView = '/DownloadSeeAllPhotosVideosView';
  static const String favouritesVideoReelsView = '/FavouritesVideoReelsView';
  static const String favouritesPhotosReels = '/FavouritesPhotosReels';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case languageView:
        final bool isSplashLanguage = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => LanguageView(
                  isSplashLanguage: isSplashLanguage,
                ));

      case bottomNavigationBarView:
        return MaterialPageRoute(builder: (_) => const BottomNavigationBarView());

      case homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case darshanView:
        return MaterialPageRoute(builder: (_) => const DarshanView());

      case reelsView:
        return MaterialPageRoute(builder: (_) => const ReelsView());

      case saveView:
        return MaterialPageRoute(builder: (_) => const SaveView());

      case darshanCategoryPhotosReel:
        final args = settings.arguments as int;
        final bool isDarshanLike = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (_) => DarshanCategoryPhotosReel(
            index: args,
            isDarshanLike: isDarshanLike,
          ),
        );

      case combinedCategoryVideoReelView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CombinedCategoryVideoReel(
            index: args['index'],
            isDarshan: args['isDarshan'],
          ),
        );

      case dailyDarshanSubCategoryView:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => DailyDarshanSubCategory(categoryName: args),
        );

      case favouritesSeeAllPhotosView:
        return MaterialPageRoute(builder: (_) => const FavouritesSeeAllPhotosView());

      case favouriteSeeAllVideoView:
        return MaterialPageRoute(builder: (_) => const FavouriteSeeAllVideoView());

      case downloadPhotoReelsView:
        final index = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => DownloadPhotoReelsView(
                  index: index,
                ));

      case downloadVideoReelsView:
        final index = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => DownloadVideoReelsView(
                  index: index,
                ));

      case downloadSeeAllPhotosVideosView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => DownloadSeeAllPhotosVideosView(
            isPhotos: args['isPhotos'],
            thumbnailList: args['thumbnailList'],
            downloadedList: args['downloadedList'],
          ),
        );

      case favouritesVideoReelsView:
        final index = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => FavouritesVideoReelsView(
                  index: index,
                ));

      case favouritesPhotosReels:
        final index = settings.arguments as int;
        final bool isDarshanLike = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => FavouritesPhotosReels(
                  index: index,
                  isDarshanLike: isDarshanLike,
                ));

      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
