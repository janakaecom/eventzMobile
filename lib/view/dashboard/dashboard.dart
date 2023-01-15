import 'dart:convert';
import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/all_event_response.dart';
import 'package:eventz/model/error_response.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/dashboard/event_details.dart';
import 'package:eventz/view/widget/app_bar.dart';
import 'package:eventz/view/widget/app_drawer.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DashBoard extends StatefulWidget {
  static var routeName = "/dashboard_view";

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with BaseUI {
  List<EventsResult> eventList;

  @override
  void initState() {
    super.initState();
    print("Event load 01");
    downloadAllEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: BaseAppBar(
          title: 'event_calender'.tr,
          menuList: [],
          isDrawerShow: true,
          isBackShow: false),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.kBackgroundWhite,
          child: Stack(
            children: [
              bgView(),
              SizedBox(
                height: Get.height - 100,
                child: SafeArea(
                    child:
                    eventList == null?Container():
                    ListView.builder(
                        itemCount: eventList.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return _eventRow(index);
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///Event row view in list-view
  _eventRow(int index) {
    var item = eventList;
    String apiDate = item[index].eventDate.split(" ")[0];
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
      child:

      Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: AppColors.kWhite)),
            padding: const EdgeInsets.only(top: 0, left: 0.0, right: 0.0),
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(children: [
                Image.network(
                  item[index].artworkPath,
                  width: Get.width,
                  height: 200,
                  fit: BoxFit.fill,
                ),

                Container(
                  padding: const EdgeInsets.only(
                      top: 120, left: 15, right: 10, bottom: 10),
                  width: Get.width,
                  height: 200,
                  color: AppColors.appDark.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       FLText(
                      //         displayText: item[index].eventName,
                      //         textColor: AppColors.kWhite,
                      //         setToWidth: false,
                      //         fontWeight: FontWeight.bold,
                      //         textSize: AppFonts.textFieldFontSize,
                      //       ),
                      //       FLText(
                      //         displayText: item[index].hostName,
                      //         textColor: AppColors.kWhite,
                      //         setToWidth: false,
                      //         textSize: AppFonts.textFieldFontSize14,
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Row(
                      //         children: [
                      //           Image.asset(
                      //             mapIconWhite,
                      //             width: 15,
                      //             height: 15,
                      //             fit: BoxFit.fill,
                      //           ),
                      //           SizedBox(
                      //             width: 5,
                      //           ),
                      //           FLText(
                      //             displayText:item[index].eventVenue,
                      //             textColor: AppColors.kWhite,
                      //             setToWidth: false,
                      //             textSize: AppFonts.textFieldFontSize12,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // interestView(),
                      InkWell(
                        onTap: (){
                          // Get.to(EventDetails(), arguments: item);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => EventDetails(
                          //       eventsResult: eventList[index],
                          //     ),
                          //   ),
                          // );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, right: 10),
                          decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              border: Border.all(
                                color: AppColors.kWhite,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          alignment: Alignment.topRight,
                          height: 30,
                          width: 30,
                          child: Center(
                            child: Image.asset(
                              imgNext,
                              width: 15,
                              height: 15,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // priceTag(item),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10.0, top: 10.0),
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                          color: AppColors.buttonBlue.withOpacity(0.9),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: AppColors.buttonBlue)),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                            width: double.infinity,
                            child: FLText(
                              displayText: month,
                              textColor: AppColors.kWhite,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize12,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: double.infinity,
                            child: FLText(
                              displayText: date,
                              textColor: AppColors.kWhite,
                              setToWidth: false,
                              fontWeight: FontWeight.w800,
                              textSize: AppFonts.textFieldFontLarge24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 45),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FLText(
                            displayText: item[index].eventName,
                            textColor: AppColors.kWhite,
                            setToWidth: false,
                            fontWeight: FontWeight.bold,
                            textSize: AppFonts.textFieldFontSize,
                          ),
                          FLText(
                            displayText: item[index].hostName,
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
                                displayText:item[index].eventVenue,
                                textColor: AppColors.kWhite,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          // _rowBottom(item[index]),
        ],
      ),
    );
  }

  ///bottom view of the row
  _rowBottom(EventsResult item) {
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
          // FLText(
          //   textAlign: TextAlign.left,
          //   displayText: item.eventResourceObjectList[0].resName,
          //   textColor: AppColors.kTextDark,
          //   setToWidth: false,
          //   textSize: AppFonts.textFieldFontSize12,
          // ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          FLButton(
            borderRadius: 20,
            title: "enroll".tr,
            onPressed: () {
              // Get.to(EventDetails(), arguments: item);
            },
            backgroundColor: AppColors.textGreenLight,
            titleFontColor: AppColors.kWhite,
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

  // ///view for price tag
  // priceTag(AllEventResponse item) {
  //   return Align(
  //     alignment: Alignment.centerRight,
  //     child: Container(
  //       width: 100,
  //       height: 30,
  //       decoration: BoxDecoration(
  //           color: item.isPaidEvent.toUpperCase() == "TRUE"
  //               ? AppColors.kWhite
  //               : AppColors.textGreenLight,
  //           borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(8),
  //             bottomLeft: Radius.circular(8),
  //           ) // green shaped
  //           ),
  //       child: FLText(
  //         displayText: item.isPaidEvent.toUpperCase() == "TRUE"
  //             ? item.currencyName + " " + item.amount
  //             : "FREE",
  //         textColor: item.isPaidEvent.toUpperCase() == "TRUE"
  //             ? AppColors.textRed
  //             : AppColors.kWhite,
  //         setToWidth: false,
  //         textSize: AppFonts.textFieldFontSize14,
  //       ),
  //     ),
  //   );
  // }

  ///download all event from API
  void downloadAllEvent() {
    print("Event load");
    apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getAllEvent().then((value) {
          hideProgressbar(context);

          if (value.statusCode == 200) {
            // List<dynamic> responseData = jsonDecode(value.body);
            AllEventResponse responseData = AllEventResponse.fromJson(json.decode(value.body));
            setState(() {
              eventList = responseData.result;
            });
          } else {
            ErrorResponse responseData = ErrorResponse.fromJson(json.decode(value.body));
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
