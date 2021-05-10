import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/login_response.dart';
import 'package:eventz/utils/constants.dart';
import 'package:eventz/utils/shared_storage.dart';
import 'package:eventz/view/login/login_view.dart';
import 'package:eventz/view/myEvent/my_event.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  SharedPref sharedPref = SharedPref();
  String _userName = "";

  @override
  void initState() {
    getProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: appDrawerHeader(),
            ),
          ),
          Expanded(
            flex: 3,
            child: listMenus(context),
          ),
          Container(
            child: Padding(
              padding:
                  EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
              child: Text(
                "Version v3.3.3",
                style: new TextStyle(
                  fontSize: 14.0,
                  color: AppColors.kWhite,
                ),
              ),
            ),
            color: AppColors.kPrimary,
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }

  getProfileInfo() async {
    try {
      LoginResponse profileData =
          LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
      setState(() {
        _userName =
            profileData.result.firstName + " " + profileData.result.lastName;
      });
    } catch (Excepetion) {
      print(Excepetion.toString());
    }
  }

  appDrawerHeader() {
    return SizedBox(
      child: Container(
        padding: new EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
        color: AppColors.kPrimaryDark,
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10, right: 10),
              decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  border: Border.all(
                    color: AppColors.kWhite,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              alignment: Alignment.topRight,
              height: 70,
              width: 70,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  FLText(
                    // displayText: "dd",
                    displayText: _userName != null
                        ? _userName != ''
                            ? _userName
                            : "-"
                        : "-",
                    textColor: AppColors.kWhite,
                    setToWidth: false,
                    textSize: AppFonts.textFieldFontSize16,
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///list menu in drawer
  listMenus(context) {
    return Container(
      color: AppColors.kWhite,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            homeMenu("Profile", "PROFILE", profileMenu, context),
            homeMenu("All Event", "ALL_EVENT", allEventMenu, context),
            homeMenu("My Event", "MY_EVENT", myEventMenu, context),
            homeMenu(
                "Password Change", "PASSWORD_CHANGE", pwChangeMenu, context),
            homeMenu("Logout", "LOGOUT", logOutMenu, context),
          ],
        ),
      ),
    );
  }

  getPadding() {
    return EdgeInsets.only(right: 10, top: 10, left: 10, bottom: 10);
  }

  ///
  /// Home Menu
  ///
  Widget homeMenu(String tr, String action, String icon, BuildContext context) {
    return Padding(
      padding: getPadding(),
      child: InkWell(
        onTap: () async {
          print("Card tapped.$action");
          Navigator.pop(context);
          if (action == "LOGOUT") {
            sharedPref.removeAll();
            Get.offAll(LoginView());
          }
          if (action == "MY_EVENT") {
            Get.to(MyEventView());
          }
        },
        child: Row(
          children: [
            SizedBox(
                width: AppConstants.drawerIconSize,
                height: AppConstants.drawerIconSize,
                child: SvgPicture.asset(
                  icon,
                  color: AppColors.appDark,
                  width: 10,
                  height: 10,
                  matchTextDirection: true,
                )),
            SizedBox(
              width: 10,
            ),
            Text(
              tr,
              style: new TextStyle(
                fontSize: AppFonts.drawerMenuFontSize,
                color: AppColors.kTextDark,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
