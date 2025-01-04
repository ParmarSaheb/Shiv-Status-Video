class GetCategoryResponse {
  int? status;
  String? message;
  List<GetCategoryGod>? data;

  GetCategoryResponse({this.status, this.message, this.data});

  GetCategoryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'] ?? '';
    if (json['data'] != null) {
      data = <GetCategoryGod>[];
      json['data'].forEach((v) {
        data!.add(GetCategoryGod.fromJson(v));
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

class GetCategoryGod {
  int? id;
  int? languageId;
  String? categoryId;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? categorySort;
  GodCategory? category;

  GetCategoryGod(
      {this.id,
      this.languageId,
      this.categoryId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.categorySort,
      this.category});

  GetCategoryGod.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    languageId = json['language_id'] ?? 0;
    categoryId = json['category_id'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    categorySort = json['category_sort'] ?? 0;
    category = json['category'] != null ? GodCategory.fromJson(json['category']) : null;
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

class GodCategory {
  int? id;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? type;
  dynamic categoryId;
  int? sort;

  GodCategory({this.id, this.icon, this.createdAt, this.updatedAt, this.type, this.categoryId, this.sort});

  GodCategory.fromJson(Map<String, dynamic> json) {
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
