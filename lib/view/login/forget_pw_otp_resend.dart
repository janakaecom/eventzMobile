import 'dart:convert';
import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/register_error_response.dart';
import 'package:eventz/model/register_success_response.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/imput_square_text_field.dart';
import 'forget_pw_otp.dart';

class ForgetPWOtpResend extends StatefulWidget {
  @override
  _ForgetPWOtpResendState createState() => _ForgetPWOtpResendState();
}

class _ForgetPWOtpResendState extends State<ForgetPWOtpResend> with BaseUI {
  String email = Get.arguments;
  TextEditingController mobileController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("EMAIL 1: " + email);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        title:  FLText(
          displayText: "OTP Resend",
          textColor: AppColors.buttonBlue,
          fontWeight: FontWeight.bold,
          setToWidth: false,
          textSize: AppFonts.textFieldFontSize,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            color: AppColors.kBackgroundWhite,
            child: Stack(
              children: [bgView(), mainView()],
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
              const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FLText(
                        displayText: "Mobile Number",
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
                    hint: 'Please enter mobile number',
                    // maxLength: 6,
                    textController: mobileController,
                    inputType: TextInputType.number,
                    // onChanged: passwordValidationCheck
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 150,
                    child: FLButton(
                      borderRadius: 20,
                      title: "Resend",
                      onPressed: () {
                        forgetPwAPICall();
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


  void forgetPwAPICall() {
    // String email = emailController.text;
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('eventz', 'invalid_email'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (email.characters.length > 100) {
      Get.snackbar('eventz', 'Email is too long!', duration: Duration(seconds: 5),
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else {
      apiService.check().then((check) {
        showProgressbar(context);
        if (check) {
          apiService.forgetPw(email).then((value) {
            hideProgressbar(context);
            if (value.statusCode == 200) {
              // Get.to(ForgetPwOtp(), arguments: email);
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

  void resentAPICall() {
    String mobile = mobileController.text;
    if (!GetUtils.isPhoneNumber(mobile)) {
      Get.snackbar("eventz", 'invalid_mobile'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else {
      apiService.check().then((check) {
        showProgressbar(context);
        if (check) {
          apiService.forgetPwOTPResend(email, mobile).then((value) {
            hideProgressbar(context);

            if (value.statusCode == 200) {
              //Get.off(LoginView());
              RegisterSuccessResponse responseData =
                  RegisterSuccessResponse.fromJson(json.decode(value.body));
              // Get.snackbar('Success'.tr, responseData.result,
              //     colorText: AppColors.textGreenLight,
              //     backgroundColor: AppColors.kWhite);
              Get.back();
            } else {
              RegisterErrorResponse responseData =
                  RegisterErrorResponse.fromJson(json.decode(value.body));
              Get.snackbar('eventz', responseData.message,
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
          height: Get.height / 3,
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
