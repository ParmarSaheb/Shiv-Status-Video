//Reels
//PageData
class GetReelsResponse {
  int? status;
  String? message;
  GetReelsPageData? data;

  GetReelsResponse({this.status, this.message, this.data});

  GetReelsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? GetReelsPageData.fromJson(json['data']) : null;
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

// url => response => { success } => page 1
class GetReelsPageData {
  int? currentPage;
  List<GetReelsData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<GetReelsLinks>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  GetReelsPageData(
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

  GetReelsPageData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <GetReelsData>[];
      json['data'].forEach((v) {
        data!.add(GetReelsData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <GetReelsLinks>[];
      json['links'].forEach((v) {
        links!.add(GetReelsLinks.fromJson(v));
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

class GetReelsData {
  int? id;
  dynamic languageId;
  String? thumbnail;
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
  List<GetReelsCategories>? categories;
  dynamic likeVideo;

  GetReelsData(
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

  GetReelsData.fromJson(Map<String, dynamic> json) {
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
    if (json['categories'] != null) {
      categories = <GetReelsCategories>[];
      json['categories'].forEach((v) {
        categories!.add(GetReelsCategories.fromJson(v));
      });
    }
    likeVideo = json['like_video'];
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
    data['like_video'] = likeVideo;
    return data;
  }

  GetReelsData copyWith({
    int? id,
    dynamic languageId,
    String? thumbnail,
    String? likeCount,
    String? shareCount,
    String? downloadCount,
    String? createdAt,
    String? updatedAt,
    String? contentUrl,
    String? type,
    int? status,
    int? sort,
    int? isLiked,
    List<GetReelsCategories>? categories,
    dynamic likeVideo,
  }) {
    return GetReelsData(
      id: id ?? this.id,
      languageId: languageId ?? this.languageId,
      thumbnail: thumbnail ?? this.thumbnail,
      likeCount: likeCount ?? this.likeCount,
      shareCount: shareCount ?? this.shareCount,
      downloadCount: downloadCount ?? this.downloadCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      contentUrl: contentUrl ?? this.contentUrl,
      type: type ?? this.type,
      status: status ?? this.status,
      sort: sort ?? this.sort,
      isLiked: isLiked ?? this.isLiked,
      categories: categories ?? this.categories,
      likeVideo: likeVideo ?? this.likeVideo,
    );
  }
}

class GetReelsCategories {
  int? id;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? type;
  dynamic categoryId;
  int? sort;
  String? name;
  GetReelsPivot? pivot;

  GetReelsCategories(
      {this.id,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.categoryId,
      this.sort,
      this.name,
      this.pivot});

  GetReelsCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    categoryId = json['category_id'];
    sort = json['sort'];
    name = json['name'];
    pivot =
        json['pivot'] != null ? GetReelsPivot.fromJson(json['pivot']) : null;
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

class GetReelsPivot {
  int? reelId;
  int? categoryId;

  GetReelsPivot({this.reelId, this.categoryId});

  GetReelsPivot.fromJson(Map<String, dynamic> json) {
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

class GetReelsLinks {
  String? url;
  String? label;
  bool? active;

  GetReelsLinks({this.url, this.label, this.active});

  GetReelsLinks.fromJson(Map<String, dynamic> json) {
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
