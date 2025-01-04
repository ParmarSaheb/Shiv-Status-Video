import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiv_status_video/view/reels/reels_action_button.dart';

class CustomPhotosReelsPlayer extends StatefulWidget {
  const CustomPhotosReelsPlayer({
    super.key,
    required this.photos,
    required this.reel,
    this.likeCount,
    this.aspectRatio,
    this.width,
    this.height,
    this.isDarshanLike,
  });

  final double? width;
  final double? height;
  final String photos;
  final dynamic reel;
  final double? aspectRatio;
  final String? likeCount;
  final bool? isDarshanLike;

  @override
  State<CustomPhotosReelsPlayer> createState() => _CustomPhotosReelsPlayerState();
}

class _CustomPhotosReelsPlayerState extends State<CustomPhotosReelsPlayer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            widget.photos,
            width: widget.width,
            height: widget.height,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 50,
            right: 0,
            child: ReelsActionButtons(
              contentUrl: widget.photos,
              reel: widget.reel,
              likeCount: widget.likeCount,
              isDarshanLike: widget.isDarshanLike,
            ),
          ),
        ],
      ),
    );
  }
}
