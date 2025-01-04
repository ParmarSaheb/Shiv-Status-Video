import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shiv_status_video/enumeration/language_enum.dart';
import 'package:shiv_status_video/remote/api/api_service.dart';
import 'package:shiv_status_video/remote/api/api_urls.dart';
import 'package:shiv_status_video/remote/api/request_params_api.dart';
import 'package:shiv_status_video/remote/model/get_language_model.dart';
import 'package:shiv_status_video/repository/shared_prefrence_repository/shared_preferences_repository.dart';
import 'package:shiv_status_video/utils/string_file.dart';

class LanguageController extends ChangeNotifier {
  final sharedPreferencesRepository = SharedPreferencesRepository();
  GetLanguageResponse languageResponse = GetLanguageResponse();
  List<GetLanguageData> languageResponseData = <GetLanguageData>[];
  Locale _locale = LanguageEnum.en.locale;
  Locale get locale => _locale;

  bool isLoading = false;
  int selectedIndex = 0;
  int tempSelectedIndex = 0;
  bool isFirstTime = true;

  LanguageController() {
    loadLanguage();
    fetchLanguageFromApi();
  }

  Future<void> setLocale(String languageCode) async {
    _locale = Locale(languageCode);
    sharedPreferencesRepository.mSaveLanguage(languageCode);
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    String? languageCode = await sharedPreferencesRepository.mGetLanguage();
    if (languageCode != null) {
      _locale = Locale(languageCode);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime = prefs.getBool(RequestParam.isFirstTime) ?? true;
    if (!isFirstTime) {
      selectedIndex = prefs.getInt(RequestParam.selectedIndex) ?? 0;
    }
    tempSelectedIndex = selectedIndex;
    notifyListeners();
  }

  Future<void> selectTempLanguage(int index) async {
    tempSelectedIndex = index;
    notifyListeners();
  }

  Future<void> selectLanguage(int index) async {
    // selectedIndex = index;
    selectedIndex = tempSelectedIndex;
    String selectedLanguageCode = languageResponseData[selectedIndex].shortCode ?? StringFile.en;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(RequestParam.isFirstTime, false);
    await prefs.setInt(RequestParam.selectedIndex, index);

    setLocale(selectedLanguageCode);
    notifyListeners();
  }

  fetchLanguageFromApi() async {
    if (isLoading) return;
    isLoading = true;

    try {
      var response = await ApiServices(ApiBaseUrls.baseUrl).fetchMultipartData(ApiBaseUrls.getLanguages);
      GetLanguageResponse getLanguageResponse = GetLanguageResponse.fromJson(response);
      debugPrint(getLanguageResponse.data!.toString());
      languageResponseData.addAll(getLanguageResponse.data!);
      languageResponse = getLanguageResponse;

      log(languageResponse.toString());
    } catch (e) {
      log('Error fetching reels data: $e');
    }
    isLoading = false;
    notifyListeners();
  }
}
