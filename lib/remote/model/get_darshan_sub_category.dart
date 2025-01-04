class GetSubCategoriesResponse {
  int? status;
  String? message;
  List<GetSubCategoryData>? data;

  GetSubCategoriesResponse({this.status, this.message, this.data});
  GetSubCategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    message = json['message'];
    if (json['data'] != null && json['data'] is List) {
      data = (json['data'] as List)
          .map((e) => GetSubCategoryData.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      data = null;
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

class GetSubCategoryData {
  int? id;
  int? languageId;
  String? categoryId;
  String? name;
  String? createdAt;
  String? updatedAt;
  dynamic categorySort;
  Category? category;

  GetSubCategoryData(
      {this.id,
        this.languageId,
        this.categoryId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.categorySort,
        this.category,
      });

  GetSubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    categoryId = json['category_id'];
    name = json['name'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categorySort = json['category_sort'];
    category =
    json['category'] != null ? Category.fromJson(json['category']) : null;

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

class Category {
  int? id;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? type;
  String? categoryId;
  dynamic sort;

  Category(
      {this.id,
        this.icon,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.categoryId,
        this.sort});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    categoryId = json['category_id'];
    sort = json['sort'];
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
