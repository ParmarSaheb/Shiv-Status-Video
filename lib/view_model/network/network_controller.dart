// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
// import 'package:shiv_status_video/custom_view/custom_text_widget.dart';
// import 'package:shiv_status_video/utils/app_color_file.dart';
// import 'package:shiv_status_video/utils/app_fonts.dart';
// import 'package:shiv_status_video/utils/string_file.dart';
//
// class NetworkController extends ChangeNotifier {
//   final ValueNotifier<bool> isConnectedToInternet = ValueNotifier<bool>(false);
//
//   StreamSubscription? _internetConnectionStreamSubscription;
//
//   NetworkController(){
//     _internetConnectionStreamSubscription = InternetConnection().onStatusChange.listen((event) {
//       switch (event) {
//         case InternetStatus.connected:
//           isConnectedToInternet.value = true;
//           break;
//         case InternetStatus.disconnected:
//           isConnectedToInternet.value = false;
//           break;
//         default:
//           isConnectedToInternet.value = true;
//       }
//       notifyListeners();
//     });
//   }
//
//   @override
//   void dispose() {
//     _internetConnectionStreamSubscription?.cancel();
//     isConnectedToInternet.dispose();
//     super.dispose();
//   }
//
//   ///Internet Connected / DisConnected dialog
//   void showDialogBox(BuildContext context) {
//     void listener() {
//       if (isConnectedToInternet.value) {
//         Navigator.of(context).pop();
//         isConnectedToInternet.removeListener(listener);
//       }
//     }
//
//     isConnectedToInternet.addListener(listener);
//
//     showCupertinoDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: AppColorFile.whiteColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(0.r)),
//           ),
//           title: CustomTextWidget(StringFile.noInternetConnection(context),AppColorFile.blackColor, 16, AppFonts.semiBold),
//           content: CustomTextWidget(StringFile.turnOnInternetAndRetry(context), AppColorFile.blackColor, 14, AppFonts.regularFont),
//           actions: [
//             TextButton(onPressed: () {
//                if (isConnectedToInternet.value) {
//                  Navigator.of(context).pop();
//                  // subscription.cancel();
//                  isConnectedToInternet.removeListener(listener);
//                  notifyListeners();
//                }
//             }, child: CustomTextWidget(StringFile.ok(context), AppColorFile.mahadevThemeColor, 16, AppFonts.mediumFont))
//           ],
//         );
//         return CupertinoAlertDialog(
//           title: CustomTextWidget(StringFile.noInternetConnection(context), Colors.yellow, 16, AppFonts.regularFont),
//           content: CustomTextWidget(StringFile.pleaseCheckYourInternetConnection(context), Colors.yellow, 16, AppFonts.regularFont),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 if (isConnectedToInternet.value) {
//                   Navigator.of(context).pop();
//                   // subscription.cancel();
//                   isConnectedToInternet.removeListener(listener);
//                   notifyListeners();
//                 }
//               },
//               child: CustomTextWidget(StringFile.refresh(context), Colors.yellow, 16, AppFonts.regularFont),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
