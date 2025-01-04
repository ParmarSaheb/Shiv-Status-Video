import 'package:shiv_status_video/remote/api/api_service.dart';

class DarshanPhotoRepository {
  final ApiServices apiServices = ApiServices();

// Future<GetDarshanPhotoResponse?> fetchDarshanPhotosSubCategoryFromApi({
//   required String subCategories,
//   required String page,
// }) async {
//   try {
//     var cat = int.parse(subCategories);
//
//     var url = Common.getDarshanPhotoUrl(subCategories: cat, page: page);
//     debugPrint('Fetching Darshan photos from: $url');
//
//     var response = await apiServices.fetchMultipartData(url);
//
//     if (response is Map<String, dynamic>) {
//       return GetDarshanPhotoResponse.fromJson(response);
//     } else {
//       return null;
//     }
//   } catch (e, stack) {
//     debugPrint('Error fetching Darshan photos: $e');
//     debugPrintStack(stackTrace: stack);
//     return null;
//   }
// }
}
