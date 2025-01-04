class GetSaveVideosData {
  final int status;
  final String message;
  final LikeVideosData data;

  GetSaveVideosData({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetSaveVideosData.fromJson(Map<String, dynamic> json) {
    return GetSaveVideosData(
      status: json['status'],
      message: json['message'],
      data: LikeVideosData.fromJson(json['data']),
    );
  }
}

class LikeVideosData {
  final int currentPage;
  final List<LikeVideoData> data;
  final String firstPageUrl;
  final int? total;
  final int lastPage;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;

  LikeVideosData({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    this.total,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
  });

  factory LikeVideosData.fromJson(Map<String, dynamic> json) {
    return LikeVideosData(
      currentPage: json['current_page'],
      data: (json['data'] as List<dynamic>)
          .map((e) => LikeVideoData.fromJson(e))
          .toList(),
      firstPageUrl: json['first_page_url'],
      total: json['total'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}

class LikeVideoData {
  final String? id;
  final String? userId;
  final String? videoUrl;

  LikeVideoData({
    this.id,
    this.userId,
    this.videoUrl,
  });

  factory LikeVideoData.fromJson(Map<String, dynamic> json) {
    return LikeVideoData(
      id: json['id'],
      userId: json['userId'],
      videoUrl: json['videoUrl'],
    );
  }
}
