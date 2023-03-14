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
import 'package:intl/intl.dart';
import '../../model/get_user_response.dart' as ur;
import '../../model/get_user_response.dart';
import '../widget/imput_square_text_field.dart';

class EventDetails extends StatefulWidget {
  static var routeName = "/event_details";

  final EventsResult eventsResult;

  const EventDetails({Key key, this.eventsResult}) : super(key: key);

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
  AllEventResponse item = Get.arguments;
  LoginResponse profileData;
  String finalizedDate;
  ur.Result profileDataResponse;
  String nic;
  String mobileNum;
  LoginResponse loginResponse ;
  GetUserResponse responseData;

  @override
  void initState() {
    getProfileInfo();
    loadUserDate();
    downloadPaymentMode();
    super.initState();

    var val  = DateFormat("MMM \n dd").format(DateTime.parse(widget.eventsResult.eventDate));
    finalizedDate = val;

  }


  getProfileInfo() async {
    try {
      loginResponse = LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
    } catch (Excepetion) {
      print(Excepetion.toString());
    }
    showProgressbar(context);
    await getUser(loginResponse.result.userIdx);
    hideProgressbar(context);
  }




  ///get my profile details from API
  Future getUser(int userIdx) async {
    await apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getUserProfile(userIdx).then((value) async {
          hideProgressbar(context);

          if (value.statusCode == 200) {
            responseData = await GetUserResponse.fromJson(json.decode(value.body));
            setState(() {
            profileDataResponse = responseData.result;
            nic = profileDataResponse.nic;
            mobileNum = profileDataResponse.mobileNo;
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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: BaseAppBar(
          title: widget.eventsResult.eventName,
          menuList: [],
          isDrawerShow: false,
          isBackShow: true),
      body:
      SingleChildScrollView(
        child: Container(
          color:  Colors.blue.withOpacity(0.08),
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Container(
              decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack (
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            widget.eventsResult.artworkPath,
                            width: Get.width,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                        _dateView(),
                        nameView(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        FLText(
                          displayText: "Venue:",
                          textColor: Colors.black.withOpacity(0.6),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                        FLText(
                          displayText: "   ${widget.eventsResult.eventVenue}",
                          textColor: Colors.blue.withOpacity(0.7),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        FLText(
                          displayText: "Resource Person:",
                          textColor: Colors.black.withOpacity(0.6),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                        FLText(
                          displayText: "   ${widget.eventsResult.eventResourceObjectList[0].resName}",
                          textColor: Colors.blue.withOpacity(0.7),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        FLText(
                          displayText: "Organized By:",
                          textColor: Colors.black.withOpacity(0.6),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                        FLText(
                          displayText: "   ${widget.eventsResult.hostName}",
                          textColor: Colors.blue.withOpacity(0.7),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    child: Divider(
                      color: Colors.black.withOpacity(0.3),
                      thickness: 0.3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FLText(
                          displayText: "Your Information",
                          textColor: Colors.black.withOpacity(0.4),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        FLText(
                          displayText: "User Name:",
                          textColor: Colors.black.withOpacity(0.6),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                        FLText(
                          displayText: "   ${loginResponse.result.userName ?? "N/A"}",
                          textColor: Colors.blue.withOpacity(0.7),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        FLText(
                          displayText: "NIC:",
                          textColor: Colors.black.withOpacity(0.6),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                        FLText(
                          displayText: "   ${nic ?? "N/A"}",
                          textColor: Colors.blue.withOpacity(0.7),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        FLText(
                          displayText: "Mobile:",
                          textColor: Colors.black.withOpacity(0.6),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                        FLText(
                          displayText: "   ${mobileNum ?? "N/A"}",
                          textColor: Colors.blue.withOpacity(0.7),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                    child: Divider(
                      color: Colors.black.withOpacity(0.3),
                      thickness: 0.3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FLText(
                          displayText: "Additional Information",
                          textColor: Colors.black.withOpacity(0.4),
                          setToWidth: false,
                          fontWeight: FontWeight.w600,
                          textSize: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:
                    TextFormField(
                      style: TextStyle(color: Colors.black,fontSize: 13),

                      decoration: InputDecoration(
                          filled: true,
                          fillColor:  Colors.blue.withOpacity(0.08),
                          hintText: "Please Enter Vehicle Number",
                          hintStyle: TextStyle(
                              color: AppColors.kTextLight,
                              fontSize: 12),
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(width:0.7,color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(width:0.7,color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(width:0.7,color: Colors.blue),
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:
                    TextFormField(
                      style: TextStyle(color: Colors.black,fontSize: 13),

                      decoration: InputDecoration(
                          filled: true,
                          fillColor:  Colors.blue.withOpacity(0.08),
                          hintText: "Please Enter Meal Preference",
                          hintStyle: TextStyle(
                              color: AppColors.kTextLight,
                              fontSize: 12),
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(width:0.7,color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(width:0.7,color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(width:0.7,color: Colors.blue),
                          )

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:
                    TextFormField(
                      style: TextStyle(color: Colors.black,fontSize: 13),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor:  Colors.blue.withOpacity(0.08),
                          hintText: "Please Enter Coupon Code",
                          hintStyle: TextStyle(
                              color: AppColors.kTextLight,
                              fontSize: 12),
                          counterText: '',
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(width:0.7,color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(width:0.7,color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(width:0.7,color: Colors.blue),
                          )

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 50,
                            width: 320,
                            child: FLButton(
                              borderRadius: 20,
                              title: "Submit".tr,
                              onPressed: () async {

                              },
                              backgroundColor: AppColors.buttonBlue,
                              titleFontColor: AppColors.kWhite,
                              borderColor: AppColors.buttonBlue,
                              minWidth: 100,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///show date view of event
  nameView() {
    return Container(
      margin: const EdgeInsets.only(top: 140),
      child: Row(
          children: [
        SizedBox(
          width: 16,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            FLText(
              displayText: widget.eventsResult.eventName,
              textColor: Colors.white,
              setToWidth: false,
              fontWeight: FontWeight.w600,
              textSize: AppFonts.textFieldFontSize,
            ),
          ],
        )
      ]),
    );
  }

  ///Interest view
  _dateView() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 10.0, top: 10.0,right: 10),
        width: 70,
        height: 60,
        decoration: BoxDecoration(
            color: AppColors.buttonBlue.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: AppColors.buttonBlue)),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
              width: 20,
              child: FLText(
                displayText: finalizedDate.toString(),
                textColor: AppColors.kWhite,
                setToWidth: false,
                fontWeight: FontWeight.w700,
                textSize: 20,
              ),
            ),
          ],
        ),
      ),
    );

  }

  ///data details body
  dataBody() {
    return
      Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataBodyRow("Venue : ", widget.eventsResult.eventVenue),
          dataBodyRow("Resource Person : ", widget.eventsResult.eventResourceObjectList[0].resName),
          dataBodyRow("Organized By : ", "-"),
          FLText(
            displayText: "Your Information",
            textColor: AppColors.kTextDark,
            setToWidth: false,
            textSize: AppFonts.textFieldFontSize,
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
          ),

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
    print("Event id : ${widget.eventsResult.eventIdx}");
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
            eventId: int.parse(widget.eventsResult.eventIdx.toString()),
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
