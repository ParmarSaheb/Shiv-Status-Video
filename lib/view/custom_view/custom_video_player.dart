import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/view/reels/reels_action_button.dart';
import 'package:shiv_status_video/view_model/home/home_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class CustomVidPlayer extends StatefulWidget {
  const CustomVidPlayer({
    super.key,
    required this.videoPath,
    required this.thumbnailImage,
    this.width,
    this.height,
    required this.soundMuteAction,
    this.autoPlay = true,
    this.looping = true,
    this.showControls = false,
    this.allowFullScreen = true,
    this.allowPlayBackSpeedChanging = true,
    this.aspectRatio,
    this.likCount,
    this.isDownloaded = false,
    required this.reelsData,
  });

  final String thumbnailImage;
  final double? aspectRatio;
  final double? width;
  final double? height;
  final String videoPath;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool allowFullScreen;
  final bool allowPlayBackSpeedChanging;
  final bool isDownloaded;
  final int? likCount;

  final bool soundMuteAction;
  final dynamic reelsData;

  @override
  State<CustomVidPlayer> createState() => _CustomVidPlayerState();
}

class _CustomVidPlayerState extends State<CustomVidPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool showMuteIcon = false;
  HomeController? homeController;

  @override
  void initState() {
    super.initState();
    homeController = Provider.of<HomeController>(context, listen: false);
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initializeVideoPlayer() {
    if (widget.videoPath.isNotEmpty && widget.thumbnailImage.isNotEmpty) {
      /// Initialize the like count and unliked state
      WidgetsBinding.instance.addPostFrameCallback((_) {
        homeController?.likeCount = int.parse(widget.reelsData.likeCount);
        homeController?.isUnLiked = widget.reelsData.isLiked == 0;
        setState(() {});
      });

      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.thumbnailImage));
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
      _videoPlayerController.setLooping(widget.looping);

      _videoPlayerController.initialize().then((_) async {
        setState(() {});
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: widget.autoPlay,
          aspectRatio: widget.aspectRatio ?? 9.sp / 16.sp,
          looping: widget.looping,
          showControls: widget.showControls,
          allowFullScreen: widget.allowFullScreen,
          allowPlaybackSpeedChanging: widget.allowPlayBackSpeedChanging,
          allowMuting: true,
        );
        if (_chewieController.isPlaying == true) {
          _chewieController.play();
        }
      });
      _updateVolume();
      _videoPlayerController.addListener(_handleVideoPlayerStateChange);
    }
  }

  void _handleVideoPlayerStateChange() {
    if (_videoPlayerController.value.isInitialized && _videoPlayerController.value.isPlaying) {
      _updateVolume();
    }
  }

  void _updateVolume() {
    if (homeController != null) {
      if (homeController!.isMuted) {
        _videoPlayerController.setVolume(0.0);
      } else {
        _videoPlayerController.setVolume(1.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    log(' liked with scrolling reels is ====== ------- ======= ${homeController?.likeCount} ');

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            widget.thumbnailImage,
            width: widget.width,
            height: widget.height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
          ),
          _videoPlayerController.value.isInitialized
              ? Chewie(controller: _chewieController)
              : const Align(
                  alignment: Alignment.bottomCenter,
                  child: LinearProgressIndicator(
                    color: AppColorFile.mahadevThemeColor,
                  )),
          Consumer<HomeController>(
            builder: (context, homeController, child) {
              return AnimatedOpacity(
                opacity: showMuteIcon ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Center(
                  child: Image.asset(
                    homeController.isMuted ? AppAssets.muteIcon : AppAssets.unMuteIcon,
                    height: 100.h,
                    width: 100.w,
                  ),
                ),
              );
            },
          ),
          Consumer<HomeController>(
            builder: (context, homeController, child) => GestureDetector(
              onTap: () {
                homeController.toggleMute();
                showMuteIcon = true;
                Future.delayed(const Duration(seconds: 3), () {
                  showMuteIcon = false;
                  setState(() {});
                });
              },
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            bottom: 50.h,
            right: 0,
            child: widget.isDownloaded
                ? Common().actionButton(widget.reelsData.toString(), context)
                : ReelsActionButtons(
                    contentUrl: widget.reelsData.contentUrl,
                    reel: widget.reelsData,
                    likeCount: widget.likCount.toString(),
                  ),
          )
        ],
      ),
    );
  }
}
