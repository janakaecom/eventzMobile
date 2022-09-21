import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/model/login_response.dart';
import 'package:eventz/model/my_event_response.dart';
import 'package:eventz/utils/constants.dart';
import 'package:eventz/utils/shared_storage.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/widget/app_bar.dart';
import 'package:eventz/view/widget/app_drawer.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyEventQRView extends StatefulWidget {
  static var routeName = "/my_event_qr";

  @override
  _MyEventQRViewState createState() => _MyEventQRViewState();
}

class _MyEventQRViewState extends State<MyEventQRView> with BaseUI {
  ResultMyEvent item = Get.arguments;

  SharedPref sharedPref = SharedPref();
  String _userName = "";
  String _userMobile = "";
  String _userEmail = "";

  @override
  void initState() {
    getProfileInfo();
    super.initState();
  }

  getProfileInfo() async {
    try {
      LoginResponse profileData =
          LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
      setState(() {
        _userName =
            profileData.result.firstName + " " + profileData.result.lastName;
        _userMobile = profileData.result.mobileNo;
        _userEmail = profileData.result.userName;
      });
    } catch (Excepetion) {
      print(Excepetion.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: item.eventName,
          menuList: [],
          isDrawerShow: false,
          isBackShow: true),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
            color: AppColors.kBackgroundWhite,
            child: Stack(
              children: [
                bgView(),
                Column(
                  children: [
                    Center(
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: 25.0, right: 25, top: 10.0),
                          decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              border: Border.all(color: AppColors.kWhite)),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 20),
                          child: Column(
                            children: [
                              QrImage(
                                data: item.eventEnrollId,
                                version: QrVersions.auto,
                                size: 220.0,
                                backgroundColor: AppColors.kWhite,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, right: 10, bottom: 5),
                                child: Row(
                                  children: [
                                    FLText(
                                      displayText:
                                          "User Identification Number: ",
                                      textColor: AppColors.kTextLight,
                                      setToWidth: false,
                                      textSize: AppFonts.textFieldFontSize12,
                                    ),
                                    FLText(
                                      displayText: item.eventEnrollId,
                                      textColor: AppColors.textBlue,
                                      setToWidth: false,
                                      textSize: AppFonts.textFieldFontSize14,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                    eventInfo(),
                    personalInfo(),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  eventInfo() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.only(left: 25.0, right: 25, top: 10.0),
          decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(color: AppColors.kWhite)),
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FLText(
                  displayText: "Event Information",
                  textColor: AppColors.kTextDark,
                  setToWidth: false,
                  textSize: AppFonts.textFieldFontSize16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 1,
                width: Get.width,
                color: AppColors.bgGreyLine,
              ),
              labelView("Event Name: ", item.eventName),
              labelView("Event Date: ", helper.getDate(item.eventDate)),
              labelView("Event Time: ", helper.getTime(item.eventDate)),
            ],
          )),
    );
  }

  personalInfo() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.only(left: 25.0, right: 25, top: 10.0),
          decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(color: AppColors.kWhite)),
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: FLText(
                  displayText: "Personal Information",
                  textColor: AppColors.kTextDark,
                  setToWidth: false,
                  textSize: AppFonts.textFieldFontSize16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 1,
                width: Get.width,
                color: AppColors.bgGreyLine,
              ),
              labelView("Your Name: ", _userName),
              labelView("Mobile: ", _userMobile),
              labelView("Email: ", _userEmail),
            ],
          )),
    );
  }

  labelView(String label, String value) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Row(
        children: [
          FLText(
            displayText: label,
            textColor: AppColors.kTextLight,
            setToWidth: false,
            textSize: AppFonts.textFieldFontSize12,
          ),
          SizedBox(
            width: 5,
          ),
          FLText(
            displayText: value,
            textColor: AppColors.textBlue,
            setToWidth: false,
            textSize: AppFonts.textFieldFontSize12,
          ),
        ],
      ),
    );
  }
}
