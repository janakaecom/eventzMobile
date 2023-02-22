import 'dart:convert';

import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/register_error_response.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/login/forget_pw_otp_resend.dart';
import 'package:eventz/view/login/login_view.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPwOtp extends StatefulWidget {
  @override
  _ForgetPwOtpState createState() => _ForgetPwOtpState();
}

class _ForgetPwOtpState extends State<ForgetPwOtp> with BaseUI {
  TextEditingController otpController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  String email = Get.arguments;

  @override
  Widget build(BuildContext context) {
    print("EMAIL : " + email);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            color: AppColors.kBackgroundWhite,
            child: Column(
              children: [
                Stack(
                  children: [
                    bgView(),
                    mainView(),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  submitForm() {
    return Center(
      child: Container(
        width: Get.width,
        margin: const EdgeInsets.only(left: 20.0, right: 20, top: 0, bottom: 0),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FLText(
                      displayText: "OTP Verification",
                      textColor: AppColors.textBlue,
                      setToWidth: false,
                      fontWeight: FontWeight.bold,
                      textSize: AppFonts.textFieldFontLarge24,
                    ),
                  ),
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: new InputDecoration(
                        hintText: 'OTP code',
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize16),
                        labelText: 'OTP'.tr,
                        labelStyle: TextStyle(
                            color: AppColors.buttonBlue,
                            fontSize: AppFonts.textFieldFontSize16),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    controller: pwController,
                    obscureText: true,
                    decoration: new InputDecoration(
                        hintText: "Enter new password",
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize16),
                        labelText: "NEW PASSWORD",
                        labelStyle: TextStyle(
                            color: AppColors.buttonBlue,
                            fontSize: AppFonts.textFieldFontSize16),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    child: FLButton(
                      borderRadius: 20,
                      title: "Verify",
                      onPressed: () {
                        forgetPwOTPAPICall();
                      },
                      backgroundColor: AppColors.buttonBlue,
                      titleFontColor: AppColors.kWhite,
                      borderColor: AppColors.buttonBlue,
                      minWidth: 100,
                      height: 40,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    child: FLButton(
                      borderRadius: 20,
                      title: "Resend",
                      onPressed: () {
                        Get.to(ForgetPWOtpResend(), arguments: email);
                      },
                      backgroundColor: AppColors.kWhite,
                      titleFontColor: AppColors.buttonBlue,
                      borderColor: AppColors.buttonBlue,
                      minWidth: 100,
                      height: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///forget password OTP verify Call
  void forgetPwOTPAPICall() {
    String otp = otpController.text;
    String pw = pwController.text;
    if (otp.length < 6) {
      Get.snackbar('error'.tr, "Please enter valid OTP code",
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (pw.isEmpty) {
      Get.snackbar('error'.tr, 'invalid_password'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else {
      apiService.check().then((check) {
        showProgressbar(context);
        if (check) {
          apiService.forgetPwOTP(email, otp, pw).then((value) {
            hideProgressbar(context);

            if (value.statusCode == 200) {
              Get.off(LoginView());
            } else {
              RegisterErrorResponse responseData =
                  RegisterErrorResponse.fromJson(json.decode(value.body));
              Get.snackbar('error'.tr, responseData.message,
                  colorText: AppColors.textRed,
                  backgroundColor: AppColors.kWhite);
            }
          });
        } else {
          hideProgressbar(context);
          helper.showAlertView(context, 'no_internet'.tr, () {}, 'ok'.tr);
        }
      });
    }
  }

  mainView() {
    return Column(
      children: [
        SizedBox(
          height: Get.height / 4,
        ),
        // Center(
        //   child: FLText(
        //     displayText: "Forget Password OTP Verification",
        //     textColor: AppColors.kTextDark,
        //     setToWidth: false,
        //     textSize: AppFonts.textFieldFontLarge,
        //   ),
        // ),
        SizedBox(
          height: 40,
        ),
        submitForm(),
      ],
    );
  }

  bgView() {
    return Image.asset(
      mainBg,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
