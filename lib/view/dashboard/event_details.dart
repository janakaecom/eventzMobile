import 'dart:convert';

import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/all_event_response.dart';
import 'package:eventz/model/error_response.dart';
import 'package:eventz/model/login_response.dart';
import 'package:eventz/model/payment_option_response.dart';
import 'package:eventz/model/register_response.dart';
import 'package:eventz/model/save_event_request.dart';
import 'package:eventz/utils/constants.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/widget/app_bar.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventDetails extends StatefulWidget {
  static var routeName = "/event_details";

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> with BaseUI {
  TextEditingController vehicleNoController = TextEditingController();
  TextEditingController mealTypeController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  List<Paymode> paymode = List();
  Paymode selectedMode = Paymode();
  EventResult item = Get.arguments;
  LoginResponse profileData;

  @override
  void initState() {
    loadUserDate();
    downloadPaymentMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: item.eventName,
          menuList: [],
          isDrawerShow: false,
          isBackShow: true),
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
                  interestView(),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(color: AppColors.kWhite)),
                    margin:
                        const EdgeInsets.only(top: 170, left: 10, right: 10),
                    width: Get.width,
                    child: dataBody(),
                  ),
                  dateView(),
                ],
              ),
            ],
          ),
        ),
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

  ///Interest view
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

  ///data details body
  dataBody() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataBodyRow("Venue : ", item.eventVenue),
          dataBodyRow("Resource Person : ", item.speakers),
          dataBodyRow("Organized By : ", "-"),
          Container(
            padding:
                const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
            child: FLText(
              displayText: "Your Information",
              textColor: AppColors.kTextDark,
              setToWidth: false,
              textSize: AppFonts.textFieldFontSize,
            ),
          ),
          dataBodyRow(
              "User Name : ",
              profileData != null
                  ? profileData.result.firstName +
                      " " +
                      profileData.result.lastName
                  : "-"),
          dataBodyRow("NIC : ", "-"),
          dataBodyRow("Mobile : ",
              profileData != null ? profileData.result.mobileNo : "-"),
          Container(
            padding:
                const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
            child: FLText(
              displayText: "Addtional Information",
              textColor: AppColors.kTextDark,
              setToWidth: false,
              textSize: AppFonts.textFieldFontSize,
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              controller: vehicleNoController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  hintText: "Vehicle Number",
                  hintStyle: TextStyle(
                      color: AppColors.kTextLight,
                      fontSize: AppFonts.textFieldFontSize16),
                  labelText: "Please enter Vehicle Number",
                  labelStyle: TextStyle(
                      color: AppColors.buttonBlue,
                      fontSize: AppFonts.textFieldFontSize16),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red))),
            ),
          ),

          Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              controller: mealTypeController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  hintText: "Meal Prefence",
                  hintStyle: TextStyle(
                      color: AppColors.kTextLight,
                      fontSize: AppFonts.textFieldFontSize16),
                  labelText: "Please enter Meal Prefence",
                  labelStyle: TextStyle(
                      color: AppColors.buttonBlue,
                      fontSize: AppFonts.textFieldFontSize16),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red))),
            ),
          ),

          Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: TextField(
              controller: couponController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  hintText: "Coupon Code",
                  hintStyle: TextStyle(
                      color: AppColors.kTextLight,
                      fontSize: AppFonts.textFieldFontSize16),
                  labelText: "Please enter Coupon Code",
                  labelStyle: TextStyle(
                      color: AppColors.buttonBlue,
                      fontSize: AppFonts.textFieldFontSize16),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red))),
            ),
          ),

          Container(
              padding: const EdgeInsets.only(
                  top: 30, left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FLText(
                    displayText: "Payment Information",
                    textColor: AppColors.kTextDark,
                    setToWidth: false,
                    textSize: AppFonts.textFieldFontSize,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: amountController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    decoration: new InputDecoration(
                        hintText: "Amount",
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize16),
                        labelText: "Please enter Amount",
                        labelStyle: TextStyle(
                            color: AppColors.buttonBlue,
                            fontSize: AppFonts.textFieldFontSize16),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "Payment Mode",
                        textColor: AppColors.kTextLight,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize16,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      selectedMode != null
                          ? DropdownButton<Paymode>(
                              items: paymode.map(
                                (Paymode value) {
                                  return DropdownMenuItem<Paymode>(
                                    value: value,
                                    child: FLText(
                                      displayText: value.paymodeName,
                                      textColor: AppColors.kTextDark,
                                      setToWidth: false,
                                      textSize: AppFonts.textFieldFontSize16,
                                    ),
                                  );
                                },
                              ).toList(),
                              value: selectedMode,
                              onChanged: (newMode) {
                                setState(() {
                                  selectedMode = newMode;
                                });
                              },
                            )
                          : Container()
                    ],
                  ),
                ],
              )),

          Container(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: FLButton(
              borderRadius: 20,
              title: "Submit",
              onPressed: () {
                submitToAPI();
              },
              backgroundColor: AppColors.textGreenLight,
              titleFontColor: AppColors.kWhite,
              borderColor: AppColors.textGreenLight,
              minWidth: 100,
              height: 40,
            ),
          ),

          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  ///data body row view
  dataBodyRow(String label, String text) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
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

  Future<void> loadUserDate() async {
    LoginResponse data =
        LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
    setState(() {
      profileData = data;
    });
  }

  ///
  /// Download payment mode from API
  void downloadPaymentMode() {
    print("Payment load");
    apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getPaymentOptions().then((value) {
          hideProgressbar(context);

          if (value.statusCode == 200) {
            PaymentOptionsResponse responseData =
                PaymentOptionsResponse.fromJson(json.decode(value.body));
            setState(() {
              paymode = responseData.paymode;
              if (paymode.length > 0) {
                selectedMode = paymode[0];
              }
              print("SIZE : ${paymode.length}");
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

  void submitToAPI() {
    String vehicleNo = vehicleNoController.text;
    String mealType = mealTypeController.text;
    String coupon = couponController.text;
    String amount = amountController.text;
    printInfo(info: "----------");
    print("Event id : ${item.eventIdx}");
    print("USer id : ${profileData.result.userIdx}");
    print("vehicleNo : ${vehicleNo}");
    print("mealType : ${mealType}");
    print("coupon : ${coupon}");
    print("amount : ${amount}");
    print("Mode : ${selectedMode.paymodeId}");

    if (vehicleNo.isEmpty) {
      Get.snackbar('error'.tr, "Please enter vehicle number",
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (mealType.isEmpty) {
      Get.snackbar('error'.tr, "Please enter Meal Type ",
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (amount.isEmpty) {
      Get.snackbar('error'.tr, "Please enter paid Amount ",
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else {
      printInfo(info: "okkkkkkkkk");

      apiService.check().then((check) {
        SaveEventRequest request = SaveEventRequest(
            eventId: int.parse(item.eventIdx),
            userId: profileData.result.userIdx,
            vehicleNo: vehicleNo,
            mealType: mealType,
            coupunCode: coupon,
            amountPaid: double.parse(amount),
            paymodeId: int.parse(selectedMode.paymodeId));

        showProgressbar(context);
        if (check) {
          apiService.saveEvent(request.toJson()).then((value) {
            hideProgressbar(context);

            if (value.statusCode == 200) {
              RegisterSuccess responseData =
                  RegisterSuccess.fromJson(json.decode(value.body));
              helper.showAlertView(context, responseData.result, () {
                Get.back();
              }, "OK");
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
}
