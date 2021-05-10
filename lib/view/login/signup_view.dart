import 'dart:convert';

import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/register_error_response.dart';
import 'package:eventz/model/register_request.dart';
import 'package:eventz/model/register_success_response.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/login/login_view.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with BaseUI {
  TextEditingController emailController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();
  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.kBackgroundWhite,
          child: Column(
            children: [
              Image.asset(
                registerHeaderImage,
                height: 150,
                width: 100,
              ),
              registerForm(),
            ],
          ),
        ),
      ),
    );
  }

  ///Register form
  registerForm() {
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
                  FLText(
                    displayText: 'sign_up'.tr,
                    textColor: AppColors.kTextDark,
                    setToWidth: false,
                    textSize: AppFonts.textFieldFontSize,
                  ),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                        hintText: 'enter_email'.tr,
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize16),
                        labelText: 'email_cap'.tr,
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
                        hintText: 'enter_password'.tr,
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize16),
                        labelText: 'password_cap'.tr,
                        labelStyle: TextStyle(
                            color: AppColors.buttonBlue,
                            fontSize: AppFonts.textFieldFontSize16),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    controller: fNameController,
                    keyboardType: TextInputType.name,
                    decoration: new InputDecoration(
                        hintText: 'enter_first_name'.tr,
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize16),
                        labelText: 'first_name'.tr,
                        labelStyle: TextStyle(
                            color: AppColors.buttonBlue,
                            fontSize: AppFonts.textFieldFontSize16),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    controller: lNameController,
                    keyboardType: TextInputType.name,
                    decoration: new InputDecoration(
                        hintText: 'enter_last_name'.tr,
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize16),
                        labelText: 'last_name'.tr,
                        labelStyle: TextStyle(
                            color: AppColors.buttonBlue,
                            fontSize: AppFonts.textFieldFontSize16),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: new InputDecoration(
                        hintText: 'enter_mobile'.tr,
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize16),
                        labelText: 'mobile'.tr,
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
                      title: "register".tr,
                      onPressed: () {
                        signUpCall();
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

  ///Sign-up validation call
  void signUpCall() {
    print("EMAIL " + emailController.text);
    String email = emailController.text;
    String pw = pwController.text;
    String fName = fNameController.text;
    String lName = lNameController.text;
    String mobile = mobileController.text;

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('error'.tr, 'invalid_email'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (pw.isEmpty) {
      Get.snackbar('error'.tr, 'invalid_password'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (fName.isEmpty) {
      Get.snackbar('error'.tr, 'enter_first_name'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (fName.isEmpty) {
      Get.snackbar('error'.tr, 'enter_first_name'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (lName.isEmpty) {
      Get.snackbar('error'.tr, 'enter_last_name'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (!GetUtils.isPhoneNumber(mobile)) {
      Get.snackbar('error'.tr, 'invalid_mobile'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else {
      apiService.check().then((check) {
        RegisterRequest request = RegisterRequest(
            userName: email,
            firstName: fName,
            lastName: lName,
            userTypeIdx: 1,
            password: pw,
            // isActive: true,
            mobileNo: mobile,
            countryId: 1);
        showProgressbar(context);
        if (check) {
          apiService.userRegister(request.toJson()).then((value) {
            hideProgressbar(context);

            if (value.statusCode == 200) {
              RegisterSuccessResponse responseData =
                  RegisterSuccessResponse.fromJson(json.decode(value.body));
              Get.snackbar("Success", responseData.result,
                  colorText: AppColors.textGreenLight,
                  backgroundColor: AppColors.kWhite);
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
}
