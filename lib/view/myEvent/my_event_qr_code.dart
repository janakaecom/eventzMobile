import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/model/my_event_response.dart';
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
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  color: AppColors.kWhite,
                  child: QrImage(
                    data: item.eventEnrollId,
                    version: QrVersions.auto,
                    size: 270.0,
                    backgroundColor: AppColors.kWhite,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 5),
                child: Row(
                  children: [
                    FLText(
                      displayText: "Enroll ID : ",
                      textColor: AppColors.kTextLight,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FLText(
                      displayText: item.eventEnrollId,
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
