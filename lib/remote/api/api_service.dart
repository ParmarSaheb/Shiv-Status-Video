import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shiv_status_video/remote/api/request_params_api.dart';

import 'api_urls.dart';

class ApiServices {
  final Dio dioClient;

  ApiServices([String? baseUrl])
      : dioClient = Dio(BaseOptions(
          baseUrl: baseUrl ?? ApiBaseUrls.baseUrl,
          headers: {
            RequestParam.contentType: RequestParam.contentTypeApplicationToJson,
            RequestParam.acceptEncoding: RequestParam.gzip,
            RequestParam.accept: RequestParam.applicationToJson,
          },
          validateStatus: (status) {
            return status! < 500;
          },
        )) {
    dioClient.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('Request[${options.method}] => PATH: ${options.path}, DATA: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('Response[${response.statusCode}] => DATA: ${response.data}');
        return handler.next(response);
      },
      onError: (e, handler) {
        debugPrint('Error[${e.response?.statusCode}] => MESSAGE: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Future fetchApiData(String endpoint, {bool useBaseUrl = true}) async {
    try {
      final response = await dioClient.get(
        useBaseUrl ? endpoint : dioClient.options.baseUrl + endpoint,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleError(response);
      }
    } catch (e) {
      throw Exception('Error fetching user details: $e');
    }
  }

  Future postApiData(String endpoint, Map<String, dynamic> data, {bool useBaseUrl = true}) async {
    try {
      final response = await dioClient.post(
        useBaseUrl ? endpoint : dioClient.options.baseUrl + endpoint,
        data: jsonEncode(data),
      );

      debugPrint(response.data.toString());

      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleError(response);
      }
    } catch (e) {
      throw Exception('Error posting data: $e');
    }
  }

  Future putApiData(String endpoint, Map<String, dynamic> data, {bool useBaseUrl = true}) async {
    try {
      final response = await dioClient.put(
        useBaseUrl ? endpoint : dioClient.options.baseUrl + endpoint,
        data: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleError(response);
      }
    } catch (e) {
      throw Exception('Error putting data: $e');
    }
  }

  Future deleteApiData(String endpoint, {bool useBaseUrl = true}) async {
    try {
      final response = await dioClient.delete(
        useBaseUrl ? endpoint : dioClient.options.baseUrl + endpoint,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleError(response);
      }
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }

  Future postMultipart(String endpoint, Map<String, dynamic> data, {bool useBaseUrl = true}) async {
    FormData formData = FormData.fromMap(data);
    try {
      final response = await dioClient.post(
        useBaseUrl ? endpoint : dioClient.options.baseUrl + endpoint,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleError(response);
      }
    } catch (e) {
      throw Exception('Error posting multipart data: $e');
    }
  }

  Future fetchMultipartData(String endpoint) async {
    try {
      debugPrint("endpoint ==: ${dioClient.options.baseUrl}/$endpoint");
      final response = await dioClient.get(
        "${dioClient.options.baseUrl}/$endpoint",
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        _handleError(response);
      }
    } catch (e) {
      throw Exception('Error fetching multipart data: $e');
    }
  }

  void _handleError(Response response) {
    final statusCode = response.statusCode;
    final statusMessage = response.statusMessage;

    if (statusCode != null) {
      throw Exception(
        'HTTP request failed, status code: $statusCode, status message: $statusMessage',
      );
    } else {
      throw Exception('HTTP request failed with unknown status code.');
    }
  }

  // report

  Future postReport(String userId, String postId, String text) async {
    FormData formData = FormData.fromMap({
      RequestParam.userId: userId,
      RequestParam.postId: postId,
      RequestParam.text: text,
    });

    try {
      final response = await dioClient.post('/report', data: formData);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to submit report: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error submitting report: $e');
    }
  }
}
