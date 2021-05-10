import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/utils/actions/app_bar_menus.dart';
import 'package:eventz/utils/constants.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(50);

  final String title;
  final List menuList;
  bool isDrawerShow = true;
  bool isBackShow = false;
  final Function automaticallyImplyLeading;
  final backgrounColor;
  final Function(AppBarMenus) callbackWithReturn;

  BaseAppBar(
      {Key key,
      this.title,
      this.menuList,
      this.isDrawerShow,
      this.isBackShow,
      this.automaticallyImplyLeading,
      this.callbackWithReturn,
      this.backgrounColor = AppColors.kPrimaryDark})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isDrawerShow == null) {
      isDrawerShow = true;
    }
    if (isBackShow == null) {
      isBackShow = false;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.kPrimaryDark,
      statusBarBrightness: Brightness.dark,
    ));

    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: isDrawerShow,
      brightness: Brightness.dark,
      backgroundColor: backgrounColor,
      bottomOpacity: 0.0,
      leading: isBackShow
          ? Padding(
              padding: EdgeInsets.all(4.0),
              child: IconButton(
                  icon: Image.asset('assets/images/appbar/img_back_nav.png'),
                  onPressed: () {
                    Get.back();
                  }),
            )
          : null,
      elevation: 0.0,
      title: FLText(
        displayText: title,
        textColor: Colors.white,
        setToWidth: false,
        textSize: AppFonts.textFieldFontSize,
      ),
      actions: getActions(),
    );
  }

  // Container(
  // height: 80,
  // color: AppColors.kPrimary,
  //
  // );

  ///
  /// Get action bar action menu
  ///
  getActions() {
    List<Widget> list = new List();

    for (var item in menuList) {
      if (item == AppBarMenus.NOTIFY) {
        ///
        ///home Notify action menu
        ///
        list.add(SizedBox(
          width: AppConstants.appBarIconWidth,
          height: AppConstants.appBarIconWidth,
          child: IconButton(
              icon:
                  Image.asset('assets/images/appbar/img_home_notification.png'),
              onPressed: () {}),
        ));
      } else if (item == AppBarMenus.ALERT) {
        ///
        ///home alert action menu
        ///
        list.add(SizedBox(
          width: AppConstants.appBarIconWidth,
          height: AppConstants.appBarIconWidth,
          child: IconButton(
              icon: Image.asset('assets/images/appbar/img_home_alert.png'),
              onPressed: () {}),
        ));
      }

      // else if (item == AppBarMenus.SEARCH) {
      //   ///
      //   ///search alert action menu
      //   ///
      //   list.add(SizedBox(
      //     width: AppConstants.appBarIconWidth + 2,
      //     height: AppConstants.appBarIconWidth + 2,
      //     child: IconButton(
      //         icon: Image.asset(searchIcon),
      //         onPressed: () {
      //           callbackWithReturn(AppBarMenus.SEARCH);
      //         }),
      //   ));
      // }
    }

    return list;
  }
}
