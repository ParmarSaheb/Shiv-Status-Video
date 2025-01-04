import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/repository/shared_prefrence_repository/shared_preferences_repository.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/view/custom_view/custom_text_widget.dart';
import 'package:shiv_status_video/view_model/home/home_controller.dart';
import 'package:shiv_status_video/view_model/liked_provider.dart';

class ReelsActionButtons extends StatefulWidget {
  final String contentUrl;
  final dynamic reel;
  final String? likeCount;
  final bool? isDarshanLike;

  const ReelsActionButtons({super.key, required this.contentUrl, this.reel, this.likeCount, this.isDarshanLike});

  @override
  State<ReelsActionButtons> createState() => _ReelsActionButtonsState();
}

class _ReelsActionButtonsState extends State<ReelsActionButtons> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeLikes();
  }

  Future<void> _initializeLikes() async {
    final homeController = Provider.of<HomeController>(context, listen: false);

    bool isLiked = await SharedPreferencesRepository().mIsReelLiked(widget.reel.id);
    int storedLikeCount = await SharedPreferencesRepository().mGetLikeCount(widget.reel.id);

    setState(() {
      homeController.isUnLiked = !isLiked;
      homeController.likeCount = storedLikeCount > 0 ? storedLikeCount : int.parse(widget.reel.likeCount);
    });
  }

  // Future<void> _initializeLikes() async {
  //   final homeController = Provider.of<HomeController>(context);
  //   bool isLiked = await SharedPreferencesRepository().mIsReelLiked(widget.reel.id);
  //   setState(() {
  //     homeController.isUnLiked = !isLiked;
  //     if (!homeController.isUnLiked) {
  //       homeController.likeCount = int.parse(widget.reel.likeCount);
  //       // homeController.likeCount = int.tryParse(widget.reel.likeCount) ?? 0;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    File file = File(widget.contentUrl);

    return Consumer<HomeController>(
      builder: (context, homeController, child) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIconButton(
            homeController.isUnLiked ? AppAssets.icFavorite : AppAssets.icFavoriteFilled,
            () {
              homeController.toggleIsLikedUnlike(widget.reel.id, widget.reel.isLiked, (success) {
                if (success) {
                  setState(() {
                    log(' like is ======== ${homeController.likeCount}');
                  });
                }
                if (success) {
                  context.read<LikedProvider>().setToFavourite((widget.isDarshanLike ?? false) ? LikeType.image : LikeType.video, widget.reel);
                } else {
                  context.read<LikedProvider>().removeFromFavourite((widget.isDarshanLike ?? false) ? LikeType.image : LikeType.video, widget.reel);
                }
              });
            },
          ),
          CustomTextWidget(
            "${widget.isDarshanLike == true ? widget.likeCount : homeController.likeCount}",
            AppColorFile.whiteColor,
            16,
            AppFonts.regularFont,
          ),
          _buildIconButton(
            AppAssets.icWhatsappLogo,
            () {
              homeController.downloadAndSaveVideo(url: widget.contentUrl, fileName: file.path, isShare: false, isDownloadOnly: false, isWhatsAppShare: true, context: context);
            },
          ),
          _buildIconButton(
            AppAssets.icSend,
            () {
              homeController.downloadAndSaveVideo(url: widget.contentUrl, fileName: file.path, isShare: true, isDownloadOnly: false, isWhatsAppShare: false, context: context);
            },
          ),
          CustomTextWidget("${widget.reel.shareCount}", AppColorFile.whiteColor, 16, AppFonts.regularFont),
          _buildIconButton(
            AppAssets.icDownload,
            () async {
              await homeController.downloadAndSaveVideo(
                url: widget.contentUrl,
                fileName: file.path,
                isShare: false,
                isDownloadOnly: true,
                isWhatsAppShare: false,
                context: context,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildIconButton(String icon, VoidCallback onPressed) {
    double iconHeight = 35.h;
    double iconWidth = 35.h;
    return IconButton(
      icon: SvgPicture.asset(icon, height: iconHeight, width: iconWidth),
      onPressed: onPressed,
    );
  }
}
