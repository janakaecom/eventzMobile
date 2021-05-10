import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/model/my_event_response.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/myEvent/my_event_qr_code.dart';
import 'package:eventz/view/widget/app_bar.dart';
import 'package:eventz/view/widget/app_drawer.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyEventDetailsView extends StatefulWidget {
  static var routeName = "/my_event_details";

  @override
  _MyEventDetailsViewState createState() => _MyEventDetailsViewState();
}

class _MyEventDetailsViewState extends State<MyEventDetailsView> with BaseUI {
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
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      item.artworkPath,
                      width: Get.width,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    // interestView(),
                    Container(
                      padding: const EdgeInsets.only(top: 100),
                      decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          border: Border.all(color: AppColors.kWhite)),
                      margin:
                          const EdgeInsets.only(top: 170, left: 10, right: 10),
                      width: Get.width,
                      child: dataBody(),
                    ),
                    dateView(),

                    // Container(
                    //   child: FLText(
                    //     displayText: item.eventDescription,
                    //     textColor: AppColors.kSecondary,
                    //     setToWidth: false,
                    //     textSize: AppFonts.textFieldFontSize12,
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  dataBody() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FLText(
            displayText: item.eventDescription,
            textColor: AppColors.kTextDark,
            setToWidth: false,
            textSize: AppFonts.textFieldFontSize14,
          ),
          SizedBox(
            height: 30,
          ),
          dataBodyRow("Venue : ", item.eventVenue),
          dataBodyRow("Resource Person : ", item.speakers),
          dataBodyRow("Vehicle No : ", item.vehicleNo),
          dataBodyRow("Meal Type : ", item.mealType),
          dataBodyRow("Payment Mode : ", item.paymodeName),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              FLButton(
                borderRadius: 20,
                title: "QR",
                onPressed: () {
                  Get.to(MyEventQRView(), arguments: item);
                },
                backgroundColor: AppColors.kWhite,
                titleFontColor: AppColors.textGreenLight,
                borderColor: AppColors.textGreenLight,
                minWidth: 100,
                height: 40,
              ),
              SizedBox(
                width: 30,
              ),
              FLButton(
                borderRadius: 20,
                title: "Update Payment Info",
                onPressed: () {},
                backgroundColor: AppColors.textGreenLight,
                titleFontColor: AppColors.kWhite,
                borderColor: AppColors.textGreenLight,
                minWidth: 200,
                height: 40,
              ),
            ],
          )
        ],
      ),
    );
  }

  ///data body row view
  dataBodyRow(String label, String text) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 5),
      child: Row(
        children: [
          FLText(
            displayText: label,
            textColor: AppColors.kTextLight,
            setToWidth: false,
            textSize: AppFonts.textFieldFontSize14,
          ),
          SizedBox(
            width: 20,
          ),
          FLText(
            displayText: text,
            textColor: AppColors.kTextDark,
            setToWidth: false,
            textSize: AppFonts.textFieldFontSize14,
          ),
        ],
      ),
    );
  }

  ///show date view of event
  dateView() {
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
      margin: const EdgeInsets.only(top: 140, left: 30),
      child: Row(children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
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
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            FLText(
              displayText: item.eventName,
              textColor: AppColors.kTextDark,
              setToWidth: false,
              fontWeight: FontWeight.w800,
              textSize: AppFonts.textFieldFontSize,
            ),
            SizedBox(
              height: 4,
            ),
            FLText(
              displayText: item.hostName,
              textColor: AppColors.kTextLight,
              setToWidth: false,
              textSize: AppFonts.textFieldFontSize14,
            ),
          ],
        )
      ]),
    );
  }
}
