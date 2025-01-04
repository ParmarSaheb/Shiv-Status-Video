class GetSvePostData {
  final int status;
  final String message;
  final LikePhotosData data;

  GetSvePostData({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetSvePostData.fromJson(Map<String, dynamic> json) {
    return GetSvePostData(
      status: json['status'],
      message: json['message'],
      data: LikePhotosData.fromJson(json['data']),
    );
  }
}

class LikePhotosData {
  final int currentPage;
  final List<LikeData> data;
  final String firstPageUrl;
  final int? total;
  final int lastPage;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;

  LikePhotosData({
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

  factory LikePhotosData.fromJson(Map<String, dynamic> json) {
    return LikePhotosData(
      currentPage: json['current_page'],
      data: (json['data'] as List<dynamic>)
          .map((e) => LikeData.fromJson(e))
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

class LikeData {
  final String? id;
  final String? userId;
  final String? photoUrl;

  LikeData({
    this.id,
    this.userId,
    this.photoUrl,
  });

  factory LikeData.fromJson(Map<String, dynamic> json) {
    return LikeData(
      id: json['id'],
      userId: json['userId'],
      photoUrl: json['photoUrl'],
    );
  }
}
