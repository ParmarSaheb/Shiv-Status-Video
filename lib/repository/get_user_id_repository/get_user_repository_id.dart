import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shiv_status_video/remote/api/api_urls.dart';
import 'package:shiv_status_video/remote/model/get_user_model.dart';

class GetUserIdRepository {
  bool isLoading = false;
  GetUser? getUserData;

  Future<String?> mGetUserIdData() async {
    try {
      var url = Uri.parse('${ApiBaseUrls.baseUrl}${ApiBaseUrls.getUser}');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        GetUser getUserData = GetUser.fromJson(jsonResponse);
        log('Get User API call successful ====== : ${response.body}');
        return getUserData.data;
      }
    } catch (e) {
      log('Error: $e');
    }
    return null;
  }
}
