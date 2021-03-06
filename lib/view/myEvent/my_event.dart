import 'dart:convert';

import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/error_response.dart';
import 'package:eventz/model/login_response.dart';
import 'package:eventz/model/my_event_response.dart';
import 'package:eventz/utils/constants.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/myEvent/my_event_details.dart';
import 'package:eventz/view/widget/app_bar.dart';
import 'package:eventz/view/widget/app_drawer.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyEventView extends StatefulWidget {
  static var routeName = "/my_event";

  @override
  _MyEventViewState createState() => _MyEventViewState();
}

class _MyEventViewState extends State<MyEventView> with BaseUI {
  List<ResultMyEvent> myEventList = new List();

  @override
  void initState() {
    super.initState();
    loadUserDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: BaseAppBar(
            title: 'My Event',
            menuList: [],
            isDrawerShow: true,
            isBackShow: false),
        body: SingleChildScrollView(
          child: Container(
            color: AppColors.kBackgroundWhite,
            child: SizedBox(
              height: Get.height - 100,
              child: SafeArea(
                  child: ListView.builder(
                      itemCount: myEventList.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return _myEventRow(index);
                      })),
            ),
          ),
        ));
  }

  Widget _myEventRow(int index) {
    var item = myEventList.elementAt(index);
    String apiDate = item.eventDate.split(" ")[0];
    String year = "";
    String date = "";
    String month = "";
    try {
      year = apiDate.split("/")[2];
      date = apiDate.split("/")[1];
      month = helper.getMonthShortName(int.parse(apiDate.split("/")[0]) - 1);
    } catch (e) {
      date = "N/A";
    }

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10.0, right: 10.0),
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
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: AppColors.kWhite)),
            padding: const EdgeInsets.only(top: 0, left: 0.0, right: 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(children: [
                Image.network(
                  item.artworkPath,
                  width: Get.width,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 00),
                  padding: const EdgeInsets.only(
                      top: 120, left: 10, right: 10, bottom: 3),
                  width: Get.width,
                  height: 200,
                  color: AppColors.appDark.withOpacity(0.7),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.white)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FLText(
                              displayText: year,
                              textColor: AppColors.kSecondary,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize12,
                            ),
                            FLText(
                              displayText: date,
                              textColor: AppColors.kSecondary,
                              setToWidth: false,
                              fontWeight: FontWeight.w800,
                              textSize: AppFonts.textFieldFontLarge24,
                            ),
                            FLText(
                              displayText: month,
                              textColor: AppColors.kSecondary,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize12,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FLText(
                              displayText: item.eventName,
                              textColor: AppColors.kWhite,
                              setToWidth: false,
                              fontWeight: FontWeight.w800,
                              textSize: AppFonts.textFieldFontSize,
                            ),
                            FLText(
                              displayText: item.hostName,
                              textColor: AppColors.kWhite,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize14,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  mapIconWhite,
                                  width: 15,
                                  height: 15,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                FLText(
                                  displayText: item.eventVenue,
                                  textColor: AppColors.kWhite,
                                  setToWidth: false,
                                  textSize: AppFonts.textFieldFontSize12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //interestView(),
                    ],
                  ),
                ),
                // priceTag(item),
              ]),
            ),
          ),
          _rowBottom(item),
        ],
      ),
    );
  }

  ///bottom view of the row
  _rowBottom(ResultMyEvent item) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            accountSvg,
            color: AppColors.kTextDark,
            height: 20,
            width: 20,
            matchTextDirection: true,
          ),
          SizedBox(
            width: 10,
          ),
          FLText(
            textAlign: TextAlign.left,
            displayText: item.speakers,
            textColor: AppColors.kTextDark,
            setToWidth: false,
            textSize: AppFonts.textFieldFontSize12,
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          FLButton(
            borderRadius: 20,
            title: "More...",
            onPressed: () {
              Get.to(MyEventDetailsView(), arguments: item);
            },
            backgroundColor: AppColors.kWhite,
            titleFontColor: AppColors.textGreenLight,
            borderColor: AppColors.textGreenLight,
            minWidth: 100,
            height: 30,
          )
        ],
      ),
    );
  }

  ///interested button
  interestView() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 10),
        decoration: BoxDecoration(
            color: AppColors.kWhite,
            border: Border.all(
              color: AppColors.kWhite,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        alignment: Alignment.topRight,
        height: 30,
        width: 30,
        child: Center(
          child: SvgPicture.asset(
            heartSvg,
            color: AppColors.textRed,
            matchTextDirection: true,
          ),
        ),
      ),
    );
  }

  ///view for price tag
  priceTag(ResultMyEvent item) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 100,
        height: 30,
        decoration: BoxDecoration(
            color: item.isPaidEvent.toUpperCase() == "TRUE"
                ? AppColors.kWhite
                : AppColors.textGreenLight,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ) // green shaped
            ),
        child: FLText(
          displayText: item.isPaidEvent.toUpperCase() == "TRUE"
              ? "-" + " " + item.amountPaid
              : "FREE",
          textColor: item.isPaidEvent.toUpperCase() == "TRUE"
              ? AppColors.textRed
              : AppColors.kWhite,
          setToWidth: false,
          textSize: AppFonts.textFieldFontSize14,
        ),
      ),
    );
  }

  ///load user data for shared pref
  void loadUserDate() async {
    LoginResponse data =
        LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
    downloadMyEvent(data.result.userIdx);
  }

  ///get my event list from API
  void downloadMyEvent(int userIdx) {
    apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getMyEvent(1).then((value) {
          hideProgressbar(context);

          if (value.statusCode == 200) {
            MyEventResponse responseData =
                MyEventResponse.fromJson(json.decode(value.body));
            setState(() {
              myEventList = responseData.result;
            });
          } else {
            ErrorResponse responseData =
                ErrorResponse.fromJson(json.decode(value.body));
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
}
