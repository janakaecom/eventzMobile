import 'dart:convert';

import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
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

  final String email;

  const LoginView({Key key, this.email}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> with BaseUI {
  TextEditingController emailController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();


  @override
  void initState() {
    super.initState();
    if(widget.email != null) {
      emailController.text = widget.email.toString();
    }
    else{
      emailController.text = "maryse@gmail.com";
      pwController.text = "Shanuka@97";
    }
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
              bgView(),
              mainView()
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
        height: 320,
        margin: const EdgeInsets.only(left: 20.0, right: 20, top: 0),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FLText(
                      displayText: 'sign_in'.tr,
                      textColor: AppColors.textBlue,
                      setToWidth: false,
                      fontWeight: FontWeight.bold,
                      textSize: AppFonts.textFieldFontLarge24,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 5, right: 0, bottom: 15),
                          child: SizedBox(
                            width: 10,
                            height: 10,
                            child: Image.asset(
                              email,

                            ),
                          ),
                        ),
                        hintText: 'enter_email'.tr,
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize),
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
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 5, right: 0, bottom: 15),
                          child: SizedBox(
                            width: 23,
                            height: 23,
                            child: Image.asset(
                              password,
                            ),
                          ),
                        ),
                        hintText: 'enter_password'.tr,
                        hintStyle: TextStyle(
                            color: AppColors.kTextLight,
                            fontSize: AppFonts.textFieldFontSize16),
                        labelText: 'password_cap'.tr,
                        labelStyle: TextStyle(
                            color: AppColors.buttonBlue,
                            fontSize: AppFonts.textFieldFontSize),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.textRed))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Get.to(ForgetPwView());
                      },
                      child: FLText(
                        displayText: 'forgot_pw'.tr,
                        textColor: AppColors.textBlue,
                        setToWidth: false,
                        textSize: 14,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 50,
                      width: 250,
                      child: FLButton(
                        borderRadius: 20,
                        title: "sign_in".tr,
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
                  SizedBox(
                    height: 20,
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
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Get.to(SignUpView());
            },
            child: FLText(
              displayText: 'new_sign_up'.tr,
              textColor: AppColors.textBlue,
              setToWidth: false,
              textSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FLButton(
            borderRadius: 20,
            title: "SIGN UP",
            onPressed: () {
              Get.to(SignUpView());
            },
            backgroundColor: AppColors.buttonBlue,
            titleFontColor: AppColors.kWhite,
            borderColor: AppColors.kPrimaryDark,
            minWidth: 120,
            height: 40,
          )
        ],
      ),
    );
  }

  void loginAction() {
    String pw = pwController.text;
    String email = emailController.text;

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('error'.tr, 'invalid_email'.tr, duration: Duration(seconds: 5),
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    if (email.characters.length > 100) {
      Get.snackbar('eventz', "Email is too long!", duration: Duration(seconds: 5),
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (pw.isEmpty) {
      Get.snackbar('eventz', 'invalid_password'.tr, duration: Duration(seconds: 5),
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (pw.characters.length > 20) {
      Get.snackbar('eventz', 'Password must be less than 20 characters!', duration: Duration(seconds: 5),
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else {
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
              Get.snackbar("eventz", responseData.message,
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

  bgView() {
    return Image.asset(
      mainBg,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }

  mainView() {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(),
            flex: 1,
          ),
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              loginHeader,
              width: 15,
              height: 15,
              fit: BoxFit.cover,
            ),
          ),
          login(),
          SizedBox(
            height: 40,
          ),
          bottomMenus(),
          Expanded(
            child: Container(),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
