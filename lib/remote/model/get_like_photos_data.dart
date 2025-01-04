class GetLikePhotosResponse {
  int? status;
  String? message;
  GetLikePhotosPageData? data;

  GetLikePhotosResponse({this.status, this.message, this.data});

  GetLikePhotosResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? GetLikePhotosPageData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GetLikePhotosPageData {
  int? currentPage;
  List<GetLikePhotosData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  GetLikePhotosPageData(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  GetLikePhotosPageData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <GetLikePhotosData>[];
      json['data'].forEach((v) {
        data!.add(GetLikePhotosData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class GetLikePhotosData {
  int? id;
  dynamic languageId;
  dynamic thumbnail;
  String? likeCount;
  String? shareCount;
  String? downloadCount;
  String? createdAt;
  String? updatedAt;
  String? contentUrl;
  String? type;
  int? status;
  int? sort;
  int? isLiked;
  LikeVideos? likeVideos;
  List<Categories>? categories;
  LikeVideos? likeVideo;

  GetLikePhotosData(
      {this.id,
      this.languageId,
      this.thumbnail,
      this.likeCount,
      this.shareCount,
      this.downloadCount,
      this.createdAt,
      this.updatedAt,
      this.contentUrl,
      this.type,
      this.status,
      this.sort,
      this.isLiked,
      this.likeVideos,
      this.categories,
      this.likeVideo});

  GetLikePhotosData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    thumbnail = json['thumbnail'];
    likeCount = json['like_count'];
    shareCount = json['share_count'];
    downloadCount = json['download_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentUrl = json['content_url'];
    type = json['type'];
    status = json['status'];
    sort = json['sort'];
    isLiked = json['is_liked'];
    likeVideos = json['like_videos'] != null
        ? LikeVideos.fromJson(json['like_videos'])
        : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    likeVideo = json['like_video'] != null
        ? LikeVideos.fromJson(json['like_video'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['language_id'] = languageId;
    data['thumbnail'] = thumbnail;
    data['like_count'] = likeCount;
    data['share_count'] = shareCount;
    data['download_count'] = downloadCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['content_url'] = contentUrl;
    data['type'] = type;
    data['status'] = status;
    data['sort'] = sort;
    data['is_liked'] = isLiked;
    if (likeVideos != null) {
      data['like_videos'] = likeVideos!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (likeVideo != null) {
      data['like_video'] = likeVideo!.toJson();
    }
    return data;
  }
}

class LikeVideos {
  int? id;
  int? userId;
  int? reelId;
  String? createdAt;
  String? updatedAt;

  LikeVideos(
      {this.id, this.userId, this.reelId, this.createdAt, this.updatedAt});

  LikeVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    reelId = json['reel_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['reel_id'] = reelId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Categories {
  int? id;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? type;
  dynamic categoryId;
  int? sort;
  String? name;
  Pivot? pivot;

  Categories(
      {this.id,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.categoryId,
      this.sort,
      this.name,
      this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    categoryId = json['category_id'];
    sort = json['sort'];
    name = json['name'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['icon'] = icon;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    data['category_id'] = categoryId;
    data['sort'] = sort;
    data['name'] = name;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? reelId;
  int? categoryId;

  Pivot({this.reelId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    reelId = json['reel_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reel_id'] = reelId;
    data['category_id'] = categoryId;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
