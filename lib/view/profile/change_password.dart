


import 'dart:convert';

import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/error_response.dart';
import 'package:eventz/model/login_response.dart';
import 'package:eventz/model/my_event_response.dart';
import 'package:eventz/utils/constants.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/myEvent/my_event_details.dart';
import 'package:eventz/view/widget/app_bar.dart';
import 'package:eventz/view/widget/app_drawer.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../api/api_service.dart';
import '../../model/register_error_response.dart';
import '../../model/responses.dart';
import '../../utils/shared_storage.dart';
import '../widget/imput_square_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  static var routeName = "/my_event";

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> with BaseUI {

  final TextEditingController currentPasswordController = new TextEditingController();
  final TextEditingController newPasswordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();
  ValueNotifier<String> passwordValidation = ValueNotifier('');
  FocusNode _currentPasswordFocusNode;
  FocusNode _newPasswordFocusNode;
  FocusNode _confirmPasswordFocusNode;
  bool isPasswordValidate = false;
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  APIService apiService = APIService();
  SharedPref sharedPref = SharedPref();
  LoginResponse profileData;

  @override
  void initState() {
    getProfileInfo();
    super.initState();
    _currentPasswordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }


  @override
  void dispose() {
    super.dispose();
  }


  getProfileInfo() async {
    try {
      profileData = LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
    } catch (Excepetion) {
      print(Excepetion.toString());
    }
    print('ewddwde::::::::');
    print(profileData.result.userIdx);
  }



  ///host registration call
  void changePasswordCall() {
    apiService.check().then((check) {
      // ChangePasswordRequest request = ChangePasswordRequest(
      //   userId: profileData.result.userIdx,
      //   oldPassword: currentPasswordController.text,
      //   newPassword: newPasswordController.text,
      // );
      showProgressbar(context);
      if (check) {
        apiService.changePassword(profileData.result.userIdx,currentPasswordController.text,newPasswordController.text).then((value) {
          hideProgressbar(context);

          if (value.statusCode == 200) {
            HostRegistrationResponse responseData =
            HostRegistrationResponse.fromJson(json.decode(value.body));
            Get.snackbar("Success", responseData.error,
                colorText: AppColors.textGreenLight,
                backgroundColor: AppColors.kWhite);
            // Get.off(LoginView());
          } else {
            print("cdcd");
            print(value.body);
            RegisterErrorResponse responseData = RegisterErrorResponse.fromJson(json.decode(value.body));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: BaseAppBar(
            title: 'Change Password',
            menuList: [],
            isDrawerShow: true,
            isBackShow: false),
        body: SingleChildScrollView(
          child: Container(
            height: 1000,
            width: 1000,
            decoration: const BoxDecoration(
                color: AppColors.kWhite
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [


                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FLText(
                              displayText: "Current Password",
                              textColor: AppColors.kTextDark,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InputSquareTextField(
                          padding:const EdgeInsets.symmetric(vertical: 5),
                          readOnly: false,
                          // validator: validatePassword,
                          focusNode: _currentPasswordFocusNode,
                          isObscure: obscureCurrentPassword,
                          textController: currentPasswordController,
                          inputType: TextInputType.text,
                          suffixIcon: Icon(
                              obscureCurrentPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 22,
                              color: Colors.grey),
                          onSuffixPress: (){
                            setState(() {
                              obscureCurrentPassword = !obscureCurrentPassword;
                            });
                          },
                          // onChanged: passwordValidationCheck
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FLText(
                              displayText: "New Password",
                              textColor: AppColors.kTextDark,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InputSquareTextField(
                          padding:const EdgeInsets.symmetric(vertical: 5),
                          readOnly: false,
                          focusNode: _newPasswordFocusNode,
                          isObscure: obscureNewPassword,
                          textController: newPasswordController,
                          inputType: TextInputType.text,
                          suffixIcon: Icon(
                              obscureNewPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 22,
                              color: Colors.grey),
                          onSuffixPress: (){
                            setState(() {
                              obscureNewPassword = !obscureNewPassword;
                            });
                          },
                          // onChanged: passwordValidationCheck
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FLText(
                              displayText: "Confirm Password",
                              textColor: AppColors.kTextDark,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InputSquareTextField(
                          padding:const EdgeInsets.symmetric(vertical: 5),
                          readOnly: false,
                          focusNode: _confirmPasswordFocusNode,
                          isObscure: obscureConfirmPassword,
                          textController: confirmPasswordController,
                          inputType: TextInputType.text,
                          suffixIcon: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 22,
                              color: Colors.grey),
                          onSuffixPress: (){
                            setState(() {
                              obscureConfirmPassword = !obscureConfirmPassword;
                            });
                          },
                          // onChanged: passwordValidationCheck
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (currentPasswordController.text == null || currentPasswordController.text == "" ) {
                                Get.snackbar('Error', 'Please enter the current password',
                                    colorText: AppColors.textRed,
                                    backgroundColor: AppColors.kWhite);
                              }
                              else if (newPasswordController.text == null || newPasswordController.text == "" ){
                                Get.snackbar('Error', 'Please enter a new password',
                                    colorText: AppColors.textRed,
                                    backgroundColor: AppColors.kWhite);
                              }
                              else if (!regex.hasMatch(newPasswordController.text))
                              {
                                Get.snackbar('Error', 'Enter valid password including uppercase letters, lowercase letters, numbers, special characters and minimum 8 characters.',
                                    colorText: AppColors.textRed,
                                    backgroundColor: AppColors.kWhite);
                              }
                              else if (newPasswordController.text != confirmPasswordController.text)
                              {
                                Get.snackbar('Error', "New password and confirmation password don't match",
                                    colorText: AppColors.textRed,
                                    backgroundColor: AppColors.kWhite);
                              }
                              else{
                                changePasswordCall();
                                // Get.snackbar("Success", "Successfully updated the password.",
                                //     colorText: AppColors.textGreenLight,
                                //     backgroundColor: AppColors.kWhite);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color:  Colors.deepPurpleAccent,
                                  border: Border.all(
                                      color:  Colors.deepPurpleAccent
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 24),
                                child: FLText(
                                  displayText: "Submit",
                                  textColor: Colors.white,
                                  setToWidth: false,
                                  textSize: AppFonts.textFieldFontSize14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ));
  }

}
