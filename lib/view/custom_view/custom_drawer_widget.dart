import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shiv_status_video/routes.dart';
import 'package:shiv_status_video/utils/app_assets.dart';
import 'package:shiv_status_video/utils/app_color_file.dart';
import 'package:shiv_status_video/utils/app_fonts.dart';
import 'package:shiv_status_video/utils/common.dart';
import 'package:shiv_status_video/utils/string_file.dart';
import 'package:shiv_status_video/view/custom_view/custom_image_widget.dart';
import 'package:shiv_status_video/view_model/app_change_category/app_change_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../custom_view/custom_text_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColorFile.blackColor,
      clipBehavior: Clip.none,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDrawerHeader(context),
            Divider(
              color: AppColorFile.blueColor,
              thickness: 1.sp,
            ),
            _buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return Consumer<AppChangesController>(
      builder: (context, appChangeProvider, child) {
        return Container(
          padding: EdgeInsets.fromLTRB(24.w, 50.w, 10.w, 12.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: Container(
                  height: 78.w,
                  width: 78.w,
                  color: Colors.red,
                  child: CustomImageWidget(
                    assetPath: appChangeProvider.selectedAppChange.appLogo,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ),
              10.horizontalSpace,
              Flexible(
                child: CustomTextWidget(
                  appChangeProvider.getLocalizedAppName(context),
                  AppColorFile.whiteColor,
                  textAlign: TextAlign.center,
                  24.sp,
                  AppFonts.akayaFonts,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        6.verticalSpace,
        Common.menuItem(
          context: context,
          icon: AppAssets.languageIcon,
          title: StringFile.language(context),
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.languageView, arguments: true);
          },
        ),
        Common.menuItem(
          context: context,
          icon: AppAssets.rateIcon,
          title: StringFile.rate(context),
          onTap: () {
            launchUrl(Uri.parse(StringFile.rateLink));
          },
        ),
        Common.menuItem(
          context: context,
          icon: AppAssets.shareIcon,
          title: StringFile.share(context),
          onTap: () {
            Share.share(StringFile.sendMessage(context));
          },
        ),
        Common.menuItem(
          context: context,
          icon: AppAssets.policyIcon,
          title: StringFile.privacyPolicy(context),
          onTap: () {
            launchUrl(Uri.parse(StringFile.privacyPolicyLink));
          },
        ),
      ],
    );
  }
}
