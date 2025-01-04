import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/string_file.dart';

class ImageLoader extends StatelessWidget {
  final String imagePath;

  const ImageLoader({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: File(imagePath).exists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColorFile.blackColor,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.data == true) {
          return Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          );
        } else {
          return Center(
            child: Text("${StringFile.imageNotFoundAtPath}:$imagePath"),
          );
        }
      },
    );
  }
}
