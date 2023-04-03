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

import '../../model/country_codes_response.dart';
import '../../model/error_response.dart';
import '../../model/hosts_response.dart';
import '../widget/imput_square_text_field.dart';

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
  FocusNode _currentPasswordFocusNode;
  FocusNode _newPasswordFocusNode;
  FocusNode _confirmPasswordFocusNode;
  bool isPasswordValidate = false;
  String _countryCodesDropDownValue;
  List<CountryCodeCountries> countryCodesList = [];
  List<String> venuesListNames = [];
  List<String> countryCodes = [];
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  int countryCodeId;
  String selectedCountryCode;
  bool obscureConfirmPassword = true;


  @override
  void initState() {
    super.initState();

    getAllCodes();

  }


  ///get all codes from API
  void getAllCodes() {
    print("codes load");
    apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getAllCodes().then((value) {
          hideProgressbar(context);
          if (value.statusCode == 200) {
            CountryCodesResponse responseData =
            CountryCodesResponse.fromJson(json.decode(value.body));
            setState(() {
              countryCodesList = responseData.countryCodeCountries;
              for (int i = 0; i < countryCodesList.length; i++) {
                countryCodes.add(countryCodesList[i].countryCode);
              }
            });
          } else {
            hideProgressbar(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 100,
              ),
              registerForm(),
              SizedBox(
                height: 40,
              ),
              bottomMenus(),
              SizedBox(
                height: 40,
              ),
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
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            // Container(
            //   width: Get.width,
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FLText(
                  displayText: 'sign_up'.tr,
                  textColor: AppColors.textBlue,
                  setToWidth: false,
                  fontWeight: FontWeight.bold,
                  textSize: AppFonts.textFieldFontLarge24,
                ),
              ]
            ),

            SizedBox(
              height: 5,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                FLText(
                  displayText: "First Name",
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
              hint: "Enter your first name",
              textController: fNameController,
              inputType: TextInputType.text,
              // onChanged: passwordValidationCheck
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FLText(
                  displayText: "Last Name",
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
              textController: lNameController,
              hint: "Enter your last name",
              inputType: TextInputType.text,
              // onChanged: passwordValidationCheck
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FLText(
                  displayText: "Email",
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
              textController: emailController,
              hint: "Enter your email",
              inputType: TextInputType.text,
              // onChanged: passwordValidationCheck
            ),

            SizedBox(
              height: 8,
            ),
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
              height: 8,
            ),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: AppColors.TextGray.withOpacity(0.5),
                          width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: _countryCodesDropDownValue == null
                            ? Text('Code',style: TextStyle(fontSize: 14,color: AppColors.kTextLight),)
                            : Text(
                          _countryCodesDropDownValue,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: AppFonts.circularStd),
                        ),

                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppFonts.circularStd),
                        items: countryCodesList.map(
                              (val) {
                            return DropdownMenuItem<CountryCodeCountries>(
                              value: val,
                              child: Text(val.countryCode),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                                () {
                              _countryCodesDropDownValue = val.countryCode;
                              // countryCodeId = int.parse(val.countryCodeId);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InputRoundedTextField(
                    padding:const EdgeInsets.symmetric(vertical: 5),
                    readOnly: false,
                    // validator: validatePassword,
                    textController: mobileController,
                    hint: "Enter mobile number",
                    inputType: TextInputType.text,
                    // onChanged: passwordValidationCheck
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FLText(
                  displayText: "Password",
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
              hint: "Enter your password",
              focusNode: _currentPasswordFocusNode,
              isObscure: obscureCurrentPassword,
              textController: pwController,
              inputType: TextInputType.text,
              suffixIcon: Icon(
                  obscureCurrentPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 22,
                  color: Colors.grey),
              onSuffixPress: (){
                setState(() {
                  obscureCurrentPassword = !obscureCurrentPassword;
                });
              },
              // onChanged: passwordValidationCheck
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FLText(
                  displayText: "Confirm Password",
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
              hint: "Confirm your password",
              focusNode: _confirmPasswordFocusNode,
              isObscure: obscureConfirmPassword,
              textController: confirmPWController,
              inputType: TextInputType.text,
              suffixIcon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  size: 22,
                  color: Colors.grey),
              onSuffixPress: (){
                setState(() {
                  obscureConfirmPassword = !obscureConfirmPassword;
                });
              },
              // onChanged: passwordValidationCheck
            ),

            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              child: FLButton(
                borderRadius: 20,
                title: "SIGN UP",
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

        ],
      ),
    );
  }

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
              displayText: " Already Signed up? ",
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
            title: "SIGN IN",
            onPressed: () {
              Get.to(LoginView());
            },
            backgroundColor: AppColors.buttonBlue,
            titleFontColor: AppColors.kWhite,
            borderColor: Colors.transparent,
            minWidth: 100,
            height: 40,
          )
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


    if (fName.isEmpty) {
      Get.snackbar('eventz', 'enter_first_name'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (fName.characters.length > 50) {
      Get.snackbar('eventz', 'First name must be less than 50 characters!', duration: Duration(seconds: 5),
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (lName.isEmpty) {
      Get.snackbar('eventz', 'enter_last_name'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (lName.characters.length > 50) {
      Get.snackbar('eventz', 'Last name must be less than 50 characters!', duration: Duration(seconds: 5),
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (!GetUtils.isEmail(email)) {
    Get.snackbar('eventz', 'invalid_email'.tr,
    colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (email.characters.length > 100) {
    Get.snackbar('eventz', 'Email is too long!', duration: Duration(seconds: 5),
    colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (pw.isEmpty) {
    Get.snackbar('eventz', 'invalid_password'.tr,
    colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (pw.characters.length > 20) {
    Get.snackbar('eventz', 'Password must be less than 20 characters!', duration: Duration(seconds: 5),
    colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (!GetUtils.isPhoneNumber(mobile)) {
      Get.snackbar('eventz', 'invalid_mobile'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (!regex.hasMatch(pwController.text)) {
      Get.snackbar('eventz', 'Enter valid password including uppercase letters, lowercase letters, numbers, special characters and minimum 8 characters.'.tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    }
    else if (confirmPWController.text != pwController.text) {
      Get.snackbar('eventz', "The Passwords you have entered don't match".tr,
          colorText: AppColors.textRed, backgroundColor: AppColors.kWhite);
    } else {
      apiService.check().then((check) {
        if (mobile.characters.first == "0") {
          setState(() {
            mobile = mobile.substring(1, mobile.characters.length - 1);
          });
        }
        RegisterRequest request = RegisterRequest(
            userName: email,
            firstName: fName,
            lastName: lName,
            userTypeIdx: 1,
            password: pw,
            // isActive: true,
            mobileNo: _countryCodesDropDownValue + mobile,
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
