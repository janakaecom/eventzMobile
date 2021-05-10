import 'dart:convert';

import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/model/error_response.dart';
import 'package:eventz/model/login_response.dart';
import 'package:eventz/utils/constants.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/dashboard/dashboard.dart';
import 'package:eventz/view/login/forget_pw_view.dart';
import 'package:eventz/view/login/signup_view.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  static var routeName = "/login_view";

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with BaseUI {
  TextEditingController emailController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: height,
          color: AppColors.kBackgroundWhite,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: AppColors.appDark,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 250, bottom: 10),
                      child: bottomMenus(),
                    ),
                  ),
                ],
              ),
              Stack(children: [
                login(),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 370),
                    height: 50,
                    width: 250,
                    child: FLButton(
                      borderRadius: 20,
                      title: "login".tr,
                      onPressed: () {
                        loginAction();
                      },
                      backgroundColor: AppColors.buttonBlue,
                      titleFontColor: AppColors.kWhite,
                      borderColor: AppColors.buttonBlue,
                      minWidth: 100,
                      height: 40,
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// get login text field
  Widget login() {
    return Center(
      child: Container(
        width: Get.width,
        height: 220,
        margin: const EdgeInsets.only(left: 20.0, right: 20, top: 150),
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
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
          child: Stack(
            children: [
              Column(
                children: [
                  FLText(
                    displayText: 'login'.capitalize.tr,
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
                            borderSide: BorderSide(color: AppColors.textRed))),
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
                            borderSide: BorderSide(color: AppColors.textRed))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// set bottom view
  bottomMenus() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(SignUpView());
          },
          child: FLText(
            displayText: 'new_sign_up'.tr,
            textColor: AppColors.kTextDark,
            setToWidth: false,
            textSize: AppFonts.textFieldFontSize,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Get.to(ForgetPwView());
          },
          child: FLText(
            displayText: 'forgot_pw'.tr,
            textColor: AppColors.kTextDark,
            setToWidth: false,
            textSize: AppFonts.textFieldFontSize,
          ),
        ),
      ],
    );
  }

  void loginAction() {
    String pw = pwController.text;
    String email = emailController.text;

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('error'.tr, 'invalid_email'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else if (pw.isEmpty) {
      Get.snackbar('error'.tr, 'invalid_password'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else {
      apiService.check().then((check) {
        showProgressbar(context);
        if (check) {
          apiService.userLogin(email, pw).then((value) {
            hideProgressbar(context);

            if (value.statusCode == 200) {
              LoginResponse responseData =
                  LoginResponse.fromJson(json.decode(value.body));

              sharedPref.save(ShardPrefKey.USER, responseData.toJson());
              sharedPref.save(ShardPrefKey.LOGIN_FLAG, 1);
              sharedPref.save(
                  ShardPrefKey.USER_NAME, responseData.result.userName);
              sharedPref.save(
                  ShardPrefKey.SESSION_TOKEN, responseData.result.token);

              Get.off(DashBoard());
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
