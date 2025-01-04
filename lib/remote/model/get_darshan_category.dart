class GetDarshanCategories {
  int? status;
  String? message;
  List<GetDarshanCategoryData>? data;

  GetDarshanCategories({this.status, this.message, this.data});

  GetDarshanCategories.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? '';
    if (json['data'] != null) {
      data = <GetDarshanCategoryData>[];
      json['data'].forEach((v) {
        data!.add(GetDarshanCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetDarshanCategoryData {
  int? id;
  int? languageId;
  String? categoryId;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? categorySort;
  DarshanCategory? category;

  GetDarshanCategoryData(
      {this.id,
        this.languageId,
        this.categoryId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.categorySort,
        this.category});

  GetDarshanCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    languageId = json['language_id'] ?? 0;
    categoryId = json['category_id'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    categorySort = json['category_sort'] ?? 0;
    if (json['category'] != null) {
      category = DarshanCategory.fromJson(json['category']);
    } else {
      category = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['language_id'] = languageId;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['category_sort'] = categorySort;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class DarshanCategory {
  int? id;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? type;
  dynamic categoryId;
  int? sort;

  DarshanCategory(
      {this.id,
        this.icon,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.categoryId,
        this.sort});

  DarshanCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    icon = json['icon'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    type = json['type'] ?? 0;
    categoryId = json['category_id'] ?? '';
    sort = json['sort'] ?? 0;
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
    return data;
  }
}
