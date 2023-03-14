import 'dart:async';
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

import '../../model/responses.dart';
import '../widget/app_bar.dart';
import '../widget/imput_square_text_field.dart';

class ForgetPwOtp extends StatefulWidget {
  @override
  _ForgetPwOtpState createState() => _ForgetPwOtpState();
}

class _ForgetPwOtpState extends State<ForgetPwOtp> with BaseUI {
  TextEditingController otpController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  String email = Get.arguments;
  FocusNode _passwordFocusNode;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    print("EMAIL : " + email);

    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: AppColors.kWhite,
      //   bottomOpacity: 0.0,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black,
      //     ), onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      //   ),
      //   elevation: 0.0,
      //   title: FLText(
      //     displayText: "OTP Verification",
      //     textColor: AppColors.buttonBlue,
      //     fontWeight: FontWeight.bold,
      //     setToWidth: false,
      //     textSize: AppFonts.textFieldFontSize,
      //   ),
      //   actions: [],
      // ),
      body: SingleChildScrollView(
        child: Container(
            color: AppColors.kBackgroundWhite,
            child: Column(
              children: [
                Stack(
                  children: [
                    bgView(),
                    Padding(
                      padding: const EdgeInsets.only(top: 62),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ), onPressed: () {
                            Navigator.of(context).pop();
                          },
                          ),
                          FLText(
                            displayText: "OTP Verification",
                            textColor: AppColors.buttonBlue,
                            fontWeight: FontWeight.bold,
                            setToWidth: false,
                            textSize: AppFonts.textFieldFontSize,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.transparent,
                            ), onPressed: () {
                          },
                          ),
                        ],
                      ),
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FLText(
                        displayText: "Enter OTP",
                        textColor: AppColors.textBlue,
                        setToWidth: false,
                        textSize: 14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  InputRoundedTextField(
                    padding:const EdgeInsets.symmetric(vertical: 5),
                    readOnly: false,
                    // validator: validatePassword,
                    hint: 'OTP code',
                    maxLength: 6,
                    textController: otpController,
                    inputType: TextInputType.number,
                    // onChanged: passwordValidationCheck
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FLText(
                            displayText: "Enter New Password",
                            textColor: AppColors.textBlue,
                            setToWidth: false,
                            textSize: 14,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      InputRoundedTextField(
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        // validator: validatePassword,

                        focusNode: _passwordFocusNode,
                        isObscure: obscurePassword,
                        textController: pwController,
                        inputType: TextInputType.text,
                        suffixIcon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 22,
                            color: Colors.grey),
                        onSuffixPress: (){
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        // onChanged: passwordValidationCheck
                      ),
                    ],
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
                    height: 15,
                  ),
                  Container(
                    width: 200,
                    child: FLButton(
                      borderRadius: 20,
                      title: "Resend",
                      onPressed: () {
                        Get.to(ForgetPWOtpResend(), arguments: email);
                      },
                      backgroundColor: AppColors.buttonBlue,
                      titleFontColor: AppColors.kWhite,
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
    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    String otp = otpController.text;
    String pw = pwController.text;
    if (otp.length < 6) {
      Get.snackbar('eventz', "Please enter valid OTP",
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (pw.isEmpty) {
      Get.snackbar('eventz', 'invalid_password'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (!regex.hasMatch(pw))
    {
      Get.snackbar('eventz',  'Enter valid password including one uppercase letter, lowercase letters, numbers, special characters and minimum 8 characters.',
          colorText: AppColors.textRed,
          backgroundColor: AppColors.kWhite);
    }
    else if (pw.characters.length > 20) {
      Get.snackbar('eventz', 'Password must be less than 20 characters!', duration: Duration(seconds: 5),
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else {
      apiService.check().then((check) {
        showProgressbar(context);
        if (check) {
          apiService.forgetPwOTP(email, otp, pw).then((value) async {
            hideProgressbar(context);

            if (value.statusCode == 200) {
              const oneSec = Duration(seconds:2);
                SuccessResponse responseData = SuccessResponse.fromJson(json.decode(value.body));
                 Get.snackbar('evnetz', responseData.result, duration: Duration(seconds: 3),
                    colorText: AppColors.textGreenLight,
                    backgroundColor: AppColors.kWhite);
              await Future.delayed(const Duration(seconds: 4));
              Get.off(LoginView(email: email,));
            } else {
              RegisterErrorResponse responseData = RegisterErrorResponse.fromJson(json.decode(value.body));
              Get.snackbar('evnetz', responseData.message,
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
          height: 0,
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
