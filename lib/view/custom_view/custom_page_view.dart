import 'package:flutter/material.dart';

class CustomPageView extends StatelessWidget {
  final List<dynamic> reels;
  final bool isMuted;
  final int initialIndex;
  final void Function(int)? onPageChanged;
  final void Function()? fetchMoreItems;
  final bool isDailyDarshan;
  final Widget Function(BuildContext, int) itemBuilder;

  const CustomPageView({
    super.key,
    required this.reels,
    required this.isMuted,
    this.initialIndex = 0,
    this.onPageChanged,
    this.fetchMoreItems,
    this.isDailyDarshan = false,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels == notification.metrics.maxScrollExtent) {
          fetchMoreItems?.call();
        }
        return true;
      },
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: reels.length,
        onPageChanged: (pageIndex) {
          if (onPageChanged != null) {
            onPageChanged!(pageIndex);
          }
        },
        controller: PageController(initialPage: initialIndex),
        itemBuilder: itemBuilder,
      ),
    );
  }
}
