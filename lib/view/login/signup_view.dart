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
  TextEditingController confirmPWController = new TextEditingController();
  TextEditingController fNameController = new TextEditingController();
  TextEditingController lNameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Stack(
      children: [
        bgView(),
        SingleChildScrollView(
          child: Column(
            children: [
              // Expanded(
              //   flex: 1,
              //   child: Container(),
              // ),
              Container(
                height: 140,
              ),
              registerForm(),
            ],
          ),
        ),
      ],
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
              SizedBox(
                // height: 520,
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FLText(
                        displayText: 'sign_up'.tr,
                        textColor: AppColors.textBlue,
                        setToWidth: false,
                        fontWeight: FontWeight.bold,
                        textSize: AppFonts.textFieldFontLarge24,
                      ),
                    ),
                    Container(
                      width: Get.width,
                      height: 40,
                    ),
                    formRow(userName, 'enter_first_name'.tr, 'first_name'.tr,
                        fNameController),
                    Container(
                      width: Get.width,
                      height: 0.25,
                      color: AppColors.appDark,
                    ),
                    formRow(userName, 'enter_last_name'.tr, 'last_name'.tr,
                        lNameController),
                    Container(
                      width: Get.width,
                      height: 0.25,
                      color: AppColors.appDark,
                    ),
                    formRow(email, 'enter_email'.tr, 'email_cap'.tr,
                        emailController),
                    Container(
                      width: Get.width,
                      height: 0.25,
                      color: AppColors.appDark,
                    ),
                    formRow(mobile, 'enter_mobile'.tr, 'mobile'.tr,
                        mobileController,
                        height: 20),
                    Container(
                      width: Get.width,
                      height: 0.25,
                      color: AppColors.appDark,
                    ),
                    formRow(password, 'enter_password'.tr, 'password_cap'.tr,
                        pwController,
                        obscureText: obscurePassword,
                        passwordIconVisibility: true
                    ),
                    Container(
                      width: Get.width,
                      height: 0.25,
                      color: AppColors.appDark,
                    ),
                    formRow(password, 're_enter_password'.tr, 'Confirm Password'.tr,
                        confirmPWController,
                        obscureText: obscureConfirmPassword,
                        passwordIconVisibility: true
                    ),
                    Container(
                      width: Get.width,
                      height: 0.25,
                      color: AppColors.appDark,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  formRow(String img, String hintText, String label,
      TextEditingController controller,
      {double height, bool obscureText = false,bool passwordIconVisibility = false}) {
    return Container(
      width: Get.width,
      height: 60,
      child: Row(
        children: [
          SizedBox(
            width: 15,
            height: height == 0 ? 15 : height,
            child: Image.asset(
              img,
              width: 15,
              height: 15,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 245,
            child: TextField(
              obscureText: obscureText,
              style: TextStyle(
                  fontSize: 18.0, height: 1, color: AppColors.appDark),
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: "",
                hintStyle: TextStyle(
                    color: AppColors.kTextLight,
                    fontSize: AppFonts.textFieldFontSize16),
                labelText: label,
                labelStyle: TextStyle(
                    color: AppColors.textBlue,
                    fontSize: AppFonts.textFieldFontSize14),
              ),
            ),
          ),
          // Visibility(
          //   visible: passwordIconVisibility,
          //   child:
          //   GestureDetector(
          //     onTap: (){
          //       print('dwdcwcw');
          //       print(obscureText);
          //       setState(() {
          //         obscureText = !obscureText;
          //       });
          //       print('dwdcwcw=====');
          //       print(obscureText);
          //     },
          //     child: Icon(
          //       obscureText
          //           ? Icons.visibility
          //           : Icons.visibility_off,
          //       size: 20,
          //       color: Colors.grey,
          //     ),
          //   ),
            // IconButton(
            //   iconSize: 20,
            //   icon: Icon(
            //     obscureText == false
            //       ? Icons.visibility
            //       : Icons.visibility_off,),
            //     color: Colors.black,
            //   onPressed: () {
            //     setState(() {
            //   obscureText = !obscureText;
            // });
            //     },
            //
            // ),
          // ),
        ],
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

    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');


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
    }
    else if (!regex.hasMatch(pwController.text)) {
      Get.snackbar('error'.tr, 'Enter valid password including uppercase letters, lowercase letters, numbers, special characters and minimum 8 characters.'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (confirmPWController.text != pwController.text) {
      Get.snackbar('error'.tr, "The Passwords you have entered don't match".tr,
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

  bgView() {
    return Image.asset(
      mainBg,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );
  }
}
