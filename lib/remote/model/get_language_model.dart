class GetLanguageResponse {
  int? status;
  String? message;
  List<GetLanguageData>? data;

  GetLanguageResponse({this.status, this.message, this.data});

  GetLanguageResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] == null
        ? null
        : (json["data"] as List)
            .map((e) => GetLanguageData.fromJson(e))
            .toList();
  }

  static List<GetLanguageResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => GetLanguageResponse.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> mData = <String, dynamic>{};
    mData["status"] = status;
    mData["message"] = message;
    if (data != null) {
      mData["data"] = data?.map((e) => e.toJson()).toList();
    }
    return mData;
  }

  GetLanguageResponse copyWith({
    int? status,
    String? message,
    List<GetLanguageData>? data,
  }) =>
      GetLanguageResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );
}

class GetLanguageData {
  int? id;
  String? name;
  String? icon;
  String? createdAt;
  String? updatedAt;
  String? shortCode;
  int? isDefault;

  GetLanguageData(
      {this.id,
      this.name,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.shortCode,
      this.isDefault});

  GetLanguageData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    icon = json["icon"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    shortCode = json["short_code"];
    isDefault = json["is_default"];
  }

  static List<GetLanguageData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => GetLanguageData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["icon"] = icon;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["short_code"] = shortCode;
    data["is_default"] = isDefault;
    return data;
  }

  GetLanguageData copyWith({
    int? id,
    String? name,
    String? icon,
    String? createdAt,
    String? updatedAt,
    String? shortCode,
    int? isDefault,
  }) =>
      GetLanguageData(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        shortCode: shortCode ?? this.shortCode,
        isDefault: isDefault ?? this.isDefault,
      );
}
