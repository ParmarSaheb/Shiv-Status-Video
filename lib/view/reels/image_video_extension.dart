import 'dart:io';

// Extension to validate image file types

extension ImageFileType on File {
  bool get isValidImageType {
    final validExtensions = ['.jpg', '.jpeg', '.png', '.webp', '.svg'];
    return validExtensions.any((ext) => path.toLowerCase().endsWith(ext));
  }
}

// Extension to validate video file types

extension VideoFileType on File {
  bool get isValidVideoType {
    final validExtensions = ['.mp4', '.mov', '.avi', '.mkv', '.flv'];
    return validExtensions.any((ext) => path.toLowerCase().endsWith(ext));
  }
}
