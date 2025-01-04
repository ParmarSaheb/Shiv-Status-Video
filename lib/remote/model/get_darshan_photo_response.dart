class GetDarshanPhotoResponse {
  int? status;
  String? message;
  GetDarshanPhotosPage? data;

  GetDarshanPhotoResponse({this.status, this.message, this.data});

  GetDarshanPhotoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? '';
    if (json['data'] != null) {
      data = GetDarshanPhotosPage.fromJson(json['data']);
    } else {
      data = null;
    }
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

class GetDarshanPhotosPage {
  int? currentPage;
  List<GetDarshanPhotos>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<GetDarshanPhotosLinks>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  GetDarshanPhotosPage(
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

  GetDarshanPhotosPage.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'] ?? 0;
    if (json['data'] != null) {
      data = <GetDarshanPhotos>[];
      json['data'].forEach((v) {
        data!.add(GetDarshanPhotos.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'] ?? '';
    from = json['from'] ?? 0;
    lastPage = json['last_page'] ?? 0;
    lastPageUrl = json['last_page_url'] ?? '';
    if (json['links'] != null) {
      links = <GetDarshanPhotosLinks>[];
      json['links'].forEach((v) {
        links!.add(GetDarshanPhotosLinks.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'] ?? '';
    path = json['path'] ?? '';
    perPage = json['per_page'] ?? 0;
    prevPageUrl = json['prev_page_url'] ?? '';
    to = json['to'] ?? 0;
    total = json['total'] ?? 0;
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

class GetDarshanPhotos {
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
  List<GetDarshanPhotosCategories>? categories;
  GetDarshanPhotosLikeVideo? likeVideo;

  GetDarshanPhotos(
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
        this.categories,
        this.likeVideo});

  GetDarshanPhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    languageId = json['language_id'] ?? '';
    thumbnail = json['thumbnail'] ?? '';
    likeCount = json['like_count'] ?? '';
    shareCount = json['share_count'] ?? '';
    downloadCount = json['download_count'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    contentUrl = json['content_url'] ?? '';
    type = json['type'] ?? '';
    status = json['status'] ?? 0;
    sort = json['sort'] ?? 0;
    isLiked = json['is_liked'] ?? 0;
    if (json['categories'] != null) {
      categories = <GetDarshanPhotosCategories>[];
      json['categories'].forEach((v) {
        categories!.add(GetDarshanPhotosCategories.fromJson(v));
      });
    }
    likeVideo = json['like_video'] != null
        ? GetDarshanPhotosLikeVideo.fromJson(json['like_video'])
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
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (likeVideo != null) {
      data['like_video'] = likeVideo!.toJson();
    }
    return data;
  }
}

class GetDarshanPhotosCategories {
  int? id;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? type;
  dynamic categoryId;
  int? sort;
  String? name;
  GetDarshanPhotosPivot? pivot;

  GetDarshanPhotosCategories(
      {this.id,
        this.icon,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.categoryId,
        this.sort,
        this.name,
        this.pivot});

  GetDarshanPhotosCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    icon = json['icon'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    type = json['type'] ?? 0;
    categoryId = json['category_id'] ?? '';
    sort = json['sort'] ?? 0;
    name = json['name'] ?? '';
    pivot = json['pivot'] != null ? GetDarshanPhotosPivot.fromJson(json['pivot']) : null;
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

class GetDarshanPhotosPivot {
  int? reelId;
  int? categoryId;

  GetDarshanPhotosPivot({this.reelId, this.categoryId});

  GetDarshanPhotosPivot.fromJson(Map<String, dynamic> json) {
    reelId = json['reel_id'] ?? 0 ?? '';
    categoryId = json['category_id'] ?? 0 ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reel_id'] = reelId;
    data['category_id'] = categoryId;
    return data;
  }
}

class GetDarshanPhotosLikeVideo {
  int? id;
  int? userId;
  int? reelId;
  String? createdAt;
  String? updatedAt;

  GetDarshanPhotosLikeVideo(
      {this.id, this.userId, this.reelId, this.createdAt, this.updatedAt});

  GetDarshanPhotosLikeVideo.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userId = json['user_id'] ?? 0;
    reelId = json['reel_id'] ?? 0;
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
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

class GetDarshanPhotosLinks {
  String? url;
  String? label;
  bool? active;

  GetDarshanPhotosLinks({this.url, this.label, this.active});

  GetDarshanPhotosLinks.fromJson(Map<String, dynamic> json) {
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

