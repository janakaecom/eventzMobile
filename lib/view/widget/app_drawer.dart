import 'dart:convert';

import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/login_response.dart';
import 'package:eventz/utils/constants.dart';
import '../../model/error_response.dart';
import '../../model/get_user_response.dart' as ur;
import 'package:eventz/utils/shared_storage.dart';
import 'package:eventz/view/dashboard/dashboard.dart';
import 'package:eventz/view/login/login_view.dart';
import 'package:eventz/view/myEvent/my_event.dart';
import 'package:eventz/view/profile/change_password.dart';
import 'package:eventz/view/profile/update_profile_screen.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../model/get_user_response.dart';
import '../BaseUI.dart';
import '../forms/event_registration_step1.dart';
import '../forms/host_registrations.dart';
import '../forms/update_events.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with BaseUI {
  SharedPref sharedPref = SharedPref();
  String _userName = "";
  String imageUrl = "";
  ur.Result profileData;

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
            margin: const EdgeInsets.only(bottom: 20.0, right: 0.0),
            child: Padding(
              padding:
                  EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
              child: Text(
                "Version v3.3.3",
                style: new TextStyle(
                  fontSize: 14.0,
                  color: AppColors.appDark,
                ),
              ),
            ),
            color: AppColors.bgLightGrey,
            width: MediaQuery.of(context).size.width,
          )
        ],
      ),
    );
  }



  getProfileInfo() async {
    try {
      LoginResponse profileData = LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
      setState(() async {
        _userName = profileData.result.firstName + " " + profileData.result.lastName;
        await getUser(profileData.result.userIdx);
      });
    } catch (Excepetion) {
      print(Excepetion.toString());
    }
  }


  ///get my profile details from API
  Future getUser(int userIdx) async {
    await apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getUserProfile(userIdx).then((value) async {
          hideProgressbar(context);

          if (value.statusCode == 200) {
            GetUserResponse responseData = GetUserResponse.fromJson(json.decode(value.body));
            setState(() {
              profileData = responseData.result;
              imageUrl = profileData.profilePicURL;
            });
          } else {
            ErrorResponse responseData = ErrorResponse.fromJson(json.decode(value.body));
            // hideProgressbar(context);
            Get.snackbar('error'.tr, responseData.message,
                colorText: AppColors.textRed,
                snackPosition: SnackPosition.TOP,
                borderRadius: 0,
                borderWidth: 2,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                backgroundColor: AppColors.bgGreyLight);
          }
        });
      } else {
        hideProgressbar(context);
        helper.showAlertView(context, 'no_internet'.tr, () {}, 'ok'.tr);
      }
    });
  }


  appDrawerHeader() {
    return SizedBox(
        child: Stack(
      children: [
        Padding(
          padding: new EdgeInsets.only(top: 40, left: 0, right: 0, bottom: 10),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Image.asset(
              navHeader,
              width: 15,
              height: 15,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding:
                new EdgeInsets.only(top: 0, left: 0, right: 20, bottom: 10),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                navHeaderStar,
                width: 15,
                height: 15,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          padding:
              new EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(),
                flex: 1,
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 0, right: 0),
              //   decoration: BoxDecoration(
              //       color: AppColors.kWhite,
              //       border: Border.all(
              //         color: AppColors.kWhite,
              //       ),
              //       borderRadius: BorderRadius.all(Radius.circular(40))),
              //   alignment: Alignment.topRight,
              //   height: 70,
              //   width: 70,
              // ),
              imageUrl == null || imageUrl == "" ?
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(60)
                ),
                child: Center(
                    child:
                    Image.asset(
                      menuUser,
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                    )
                ),
              ):
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.network(
                  imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 0, top: 10),
                child:
                SizedBox(
                  width: 250,
                  child: Text(
                    _userName != null
                        ? _userName != ''
                        ? _userName
                        : "-"
                        : "-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
            ],
          ),
        ),
      ],
    ));
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
            homeMenu("Home", "HOME", menuHome, context),
            homeMenu("Event Calender", "ALL_EVENT", menuCalender, context),
            homeMenu("My Event", "MY_EVENT", menuEvent, context),
            homeMenu("My Profile", "PROFILE", userName, context),
            homeMenu("Password Change", "PASSWORD_CHANGE", password, context),
            homeMenu("Host Registration", "HOST_REG", userName, context),
            homeMenu("Event Registration", "EVENT_REG_STEP1", userName, context),
            homeMenu("Event Update", "UPDATE_EVENT", menuEvent, context),
            homeMenu("Logout", "LOGOUT", menuLogout, context),
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
          }if (action == "PROFILE") {
            Get.to(UpdateProfileScreen());
          }
          if (action == "HOST_REG") {
            Get.to(HostRegistration());
          }
          if (action == "PASSWORD_CHANGE") {
            Get.to(ChangePasswordScreen());
          }
          if (action == "UPDATE_EVENT") {
            Get.to(UpdateEvents());
          }
          if (action == "EVENT_REG_STEP1") {
            Get.to(EventRegistrationStep1());
          }
          if (action == "HOME") {
            Get.off(DashBoard());
          }
        },
        child: Row(
          children: [
            SizedBox(
                width: AppConstants.drawerIconSize,
                height: AppConstants.drawerIconSize,
                child: Image.asset(
                  icon,
                  width: 15,
                  height: 15,
                  fit: BoxFit.cover,
                )
                // SvgPicture.asset(
                //   icon,
                //   color: AppColors.appDark,
                //   width: 20,
                //   height: 20,
                //   matchTextDirection: true,
                // )
                ),
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
