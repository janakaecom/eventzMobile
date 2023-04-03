import 'dart:convert';
import 'dart:io' as files;
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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../api/api_service.dart';
import '../../model/countries_response.dart';
import '../../model/country_codes_response.dart';
import '../../model/get_user_response.dart' as ur;
import '../../model/get_user_response.dart';
import '../../model/host_register_request.dart';
import '../../model/register_error_response.dart';
import '../../model/responses.dart';
import '../../model/updateProfileResponse.dart';
import '../../model/update_profile_request.dart';
import '../../utils/shared_storage.dart';
import '../widget/imput_square_text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  static var routeName = "/my_event";

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> with BaseUI {

  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController addressController = new TextEditingController();
  final TextEditingController nicController = new TextEditingController();
  final TextEditingController passportNoController = new TextEditingController();
  final TextEditingController occupationController = new TextEditingController();
  final TextEditingController workPlaceController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController emgContactNumberController = new TextEditingController();
  final TextEditingController emgContactNameController = new TextEditingController();
  final TextEditingController titleController = new TextEditingController();
  FocusNode _passwordFocusNode;
  String logo;
  String fDate;
  DateTime pickedDate = DateTime.now();
  String _userName = "";
  String dropDownTitleValue;
  String dropDownGenderValue;
  String mobileNo;
  TextEditingController mobileController = new TextEditingController();
  String dropDownCountryValue;
  int countryIdx;
  String imageUrl;
  List<CountryCodeCountries> countryCodesList = [];
  List<String> countryCodes = [];
  FocusNode _confirmPasswordFocusNode;
  APIService apiService = APIService();
  List<Country> countryList = [];
  List<String> countryListNames = [];
  SharedPref sharedPref = SharedPref();
  LoginResponse loginResponse ;
  ur.Result profileData;
  String _countryCodesDropDownValue;
  int genderIdx;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    getProfileInfo();
    getAllCountries();
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

  getProfileInfo() async {
    try {
      loginResponse = LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
    } catch (Excepetion) {
      print(Excepetion.toString());
    }
    await getUser(loginResponse.result.userIdx);

  }



  ///get my profile details from API
  Future getUser(int userIdx) async {

    await apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getUserProfile(userIdx).then((value) async {
          hideProgressbar(context);

          if (value.statusCode == 200) {
            GetUserResponse responseData = GetUserResponse.fromJson(json.decode(value.body));
            setState(() {
              profileData = responseData.result;
              // imageUrl = profileData.profilePicURL;
              dropDownTitleValue = profileData.title;
              dropDownGenderValue = profileData.genderId == 1 ? "Male":"Female";
              firstNameController.text = profileData.firstName;
              lastNameController.text = profileData.lastName;
              mobileController.text = profileData.mobileNo;
              nicController.text = profileData.nic;


              if(profileData.dob == "1900-01-01T00:00:00"){
                dateController.text = profileData.dob.contains("1900-01-01T00:00:00") ? "YYYY-MM-DD":profileData.dob;
                setState(() {
                  var formatter = DateFormat('yyyy-MM-dd');
                  var formatted = formatter.format(DateTime.parse(profileData.dob));
                  fDate = formatted;
                  fDate = formatted;
                  print("dateController.text:::::::");
                  print(fDate);
                });
              }
              else{
                setState(() {
                  var formatter = DateFormat('yyyy-MM-dd');
                  var formatted = formatter.format(DateTime.parse(profileData.dob));
                  fDate = formatted;
                  dateController.text  = formatted;
                  print("dateController.text:::::::");
                  print(fDate);
                });
              }


              passportNoController.text = profileData.passport;
              addressController.text = profileData.address;
              countryIdx = profileData.countryId;
              occupationController.text = profileData.occupation;
              workPlaceController.text = profileData.workPlace;
              emgContactNameController.text = profileData.emgContactName;
              emgContactNumberController.text = profileData.emgContactNo;
              countryIdx = profileData.countryId;
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
  void dispose() {
    super.dispose();
  }


  ///host registration call
  void updateProfileCall() {

    setState(() {
      genderIdx = dropDownGenderValue == "Male" ? 1 : dropDownGenderValue == "Female" ? 2 : 0;
      print("dropDownGenderValue");
      print(genderIdx);
    });
    if(titleController.text == "" || titleController.text == null) {
      Get.snackbar('error'.tr, "The Title should be added",
          colorText: AppColors.textRed,
          backgroundColor: AppColors.kWhite);
    }
    else if(firstNameController.text == "" || firstNameController.text == null) {
      Get.snackbar('error'.tr, "First name can't be empty",
          colorText: AppColors.textRed,
          backgroundColor: AppColors.kWhite);
    }
    else if(lastNameController.text == "" || lastNameController.text == null) {
      Get.snackbar('error'.tr, "Last name can't be empty",
          colorText: AppColors.textRed,
          backgroundColor: AppColors.kWhite);
    }
    else if(genderIdx == null || genderIdx == 0) {
      Get.snackbar('error'.tr, "Gender should be selected",
          colorText: AppColors.textRed,
          backgroundColor: AppColors.kWhite);
    }
    else if(countryIdx == null) {
      Get.snackbar('error'.tr, "Country should be selected",
          colorText: AppColors.textRed,
          backgroundColor: AppColors.kWhite);
    }
    else {

      apiService.check().then((check) {

        print(profileData.dob);
        print("profileData.dob)))))))");




        ProfileUpdateRequest request = ProfileUpdateRequest(
            title: titleController.text,
            genderId: dropDownGenderValue.toString() == "Male" ? 1 : 2,
            nIC: nicController.text,
            passport: passportNoController.text,
            address: addressController.text,
            dOB: fDate,
            occupation: occupationController.text,
            workPlace: workPlaceController.text,
            emgContactName: emgContactNumberController.text,
            emgContactNo: emgContactNumberController.text,
            profilePicURL: imageUrl,
            userIdx: loginResponse.result.userIdx,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            countryId: countryIdx
        );
        showProgressbar(context);
        if (check) {
          apiService.userUpdate(request.toJson()).then((value) {
            hideProgressbar(context);
            if (value.statusCode == 200) {
              UpdateProfileResponse responseData =
              UpdateProfileResponse.fromJson(json.decode(value.body));
              Get.snackbar("Success", responseData.result,
                  colorText: AppColors.textGreenLight,
                  backgroundColor: AppColors.kWhite);
              // Get.off(LoginView());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: BaseAppBar(
            title: "Profile Update",
            menuList: [],
            isDrawerShow: true,
            isBackShow: false),
        body:

        Stack(
          children: [
            bgView(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: Container(

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
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                  child: SingleChildScrollView(
                    child: Column(
                        children: [

                          InkWell(
                            onTap: () {
                            },
                            child: InkWell(
                              onTap: () {
                                // imagePickerWithCrop();
                                uploadImage();
                              },
                              child:
                              imageUrl == null || imageUrl == "" ?
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: AppColors.buttonBlue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(60)
                                ),
                                child: Center(
                                    child:
                                    Image.asset(
                                      menuUser,
                                      width: 28,
                                      height: 28,
                                      color: Colors.grey,
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ):
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(
                                  imageUrl,
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FLText(
                            displayText: "Profile Picture",
                            textColor: AppColors.buttonBlue,
                            setToWidth: false,
                            textSize: AppFonts.textFieldFontSize16,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              FLText(
                                displayText: "Title",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InputRoundedTextField(
                            readOnly: false,
                            hint: "Enter your title",
                            textController: titleController,
                            inputType: TextInputType.text,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              FLText(
                                displayText: "First Name",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InputRoundedTextField(
                            readOnly: false,
                            textController: firstNameController,
                            hint: "Enter your first name",
                            inputType: TextInputType.text,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              FLText(
                                displayText: "Last Name",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          InputRoundedTextField(
                            readOnly: false,
                            hint: "Enter your last name",
                            textController: lastNameController,
                            inputType: TextInputType.text,
                            onChanged: (value) {},
                          ),


                          SizedBox(
                            height: 8,
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
                            height: 6,
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
                                  // validator: validatePassword,
                                  readOnly: false,
                                  hint: "Enter mobile number",
                                  textController: mobileController,
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
                            children: [
                              FLText(
                                displayText: "Country",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),
                            ],
                          ),


                          SizedBox(
                            height: 8,
                          ),

                          Visibility(
                            visible: countryList == null ? false : true,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.TextGray.withOpacity(0.5),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: dropDownCountryValue == null
                                        ? Text('Select your country',style: TextStyle(
                                      color: AppColors.kTextLight,
                                    ),)
                                        : Text(
                                      dropDownCountryValue,
                                      style: TextStyle(color: Colors.black,
                                          fontFamily: AppFonts.circularStd),
                                    ),
                                    isExpanded: true,
                                    iconSize: 30.0,
                                    style: TextStyle(color: Colors.black,
                                        fontFamily: AppFonts.circularStd),
                                    items: countryList.map(
                                          (val) {
                                        return DropdownMenuItem<Country>(
                                          value: val,
                                          child: Text(val.countryName.toString()),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (val) {
                                      setState(
                                            () {
                                          print("val::::::::");
                                          print(val.countryName);
                                          dropDownCountryValue = val.countryName;
                                          countryIdx = int.parse(val.countryIdx);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              FLText(
                                displayText: "Address",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InputRoundedTextField(
                            hintColor: AppColors.TextGray,
                            readOnly: true,
                            hint: "Enter your address",
                            textController: addressController,
                            inputType: TextInputType.text,
                            onChanged: (value) {},
                          ),

                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              FLText(
                                displayText: "Date of Birth",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InputRoundedTextField(
                            readOnly: false,
                            textController: dateController,
                            // hint: "YYYY-MM-DD",
                            inputType: TextInputType.datetime,
                            onSuffixPress: () {
                              dateSelection();
                            },
                            suffixIcon: Icon(Icons.chevron_right),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              FLText(
                                displayText: "Gender",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.TextGray.withOpacity(0.5),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: dropDownGenderValue == null
                                      ? Text("Select your gender",style: TextStyle(
                                    color: AppColors.kTextLight,
                                  ))
                                      : Text(
                                    dropDownGenderValue,
                                    style: TextStyle(color: Colors.black,
                                        fontFamily: AppFonts.circularStd),
                                  ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(color: Colors.black,
                                      fontFamily: AppFonts.circularStd),
                                  items: ["Male", "Female"].map(
                                        (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                          () {
                                        dropDownGenderValue = val;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              FLText(
                                displayText: "N.I.C Number",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InputRoundedTextField(
                            readOnly: false,
                            hint: "Enter your N. I. C. number",
                            textController: nicController,
                            inputType: TextInputType.text,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          Row(
                            children: [
                              FLText(
                                displayText: "Passport Number",
                                textColor: AppColors.textBlue,

                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 8,
                          ),
                          InputRoundedTextField(
                            // hint: "E",
                            hintColor: AppColors.TextGray,
                            readOnly: true,
                            hint: "Enter your passport number",
                            textController: passportNoController,
                            inputType: TextInputType.text,
                            onChanged: (value) {},
                          ),

                          SizedBox(
                            height: 8,
                          ),


                          Row(
                            children: [
                              FLText(
                                displayText: "Occupation / Profession",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          InputRoundedTextField(
                            hintColor: AppColors.TextGray,
                            readOnly: true,
                            hint: "Enter your occupation / profession",
                            textController: occupationController,
                            inputType: TextInputType.text,
                            onChanged: (value) {},
                          ),

                          SizedBox(
                            height: 8,
                          ),

                          Row(
                            children: [
                              FLText(
                                displayText: "organization",
                                textColor: AppColors.textBlue,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InputRoundedTextField(
                            hintColor: AppColors.TextGray,
                            readOnly: true,
                            hint: "Enter your organization",
                            textController: workPlaceController,
                            inputType: TextInputType.text,
                            onChanged: (value) {},
                          ),

                          SizedBox(
                            height: 40,
                          ),

                          Center(
                            child: Container(
                              height: 50,
                              width: 150,
                              child: FLButton(
                                borderRadius: 20,
                                title: "Update Profile".tr,
                                onPressed: () async {
                                  updateProfileCall();
                                },
                                backgroundColor: AppColors.buttonBlue,
                                titleFontColor: AppColors.kWhite,
                                borderColor: AppColors.buttonBlue,
                                minWidth: 100,
                                height: 40,
                              ),
                            ),
                          ),

                        ]
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  ///get all countries from API
  Future<void> getAllCountries() async{
    print("country load");
    await apiService.check().then((check) async {
      showProgressbar(context);
      if (check) {
        await apiService.getAllCountries().then((value) {
          hideProgressbar(context);
          if (value.statusCode == 200) {
            CountriesResponse responseData =
            CountriesResponse.fromJson(json.decode(value.body));
            setState(() {
              countryList = responseData.country;
              print("countryList::::::::");
              print(countryList);
              for (int i = 0; i < countryList.length; i++) {
                countryListNames.add(countryList[i].countryName);
              }
              print("countryListNames:::::::");
              print(countryListNames);
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

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = files.File(image.path);

      if (image != null){
        //Upload to Firebase
        showProgressbar(context);
        var snapshot = await _firebaseStorage.ref()
            .child('images/${DateTime.now()}')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
        hideProgressbar(context);
      } else {
        print('No Image Path Received');
        hideProgressbar(context);
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  Future<void> dateSelection() async {

    String date;
    pickedDate = await showDatePicker(
        context: context,
        lastDate: DateTime(3000),
        initialDate: DateTime.now(),
        firstDate: DateTime(1500));
    date = pickedDate.toString();



    setState(() {

      if(pickedDate.month < 10 && pickedDate.day < 10){
        fDate = "${pickedDate.year}-0${pickedDate.month}-0${pickedDate.day}";
        print(fDate);
        print("fDate:::::::");
        dateController.text = "${pickedDate.year}-0${pickedDate.month}-0${pickedDate.day}";
      }
      else if(pickedDate.month < 10 && pickedDate.day > 10){
        fDate = "${pickedDate.year}-0${pickedDate.month}-${pickedDate.day}";
        print(fDate);
        print("fDate:::::::");
        dateController.text = "${pickedDate.year}-0${pickedDate.month}-${pickedDate.day}";
      }
      else if(pickedDate.month > 10 && pickedDate.day < 10){
        fDate = "${pickedDate.year}-${pickedDate.month}-0${pickedDate.day}";
        print(fDate);
        print("fDate:::::::");
        dateController.text = "${pickedDate.year}-${pickedDate.month}-0${pickedDate.day}";
      }
      else if(pickedDate.month < 10 && pickedDate.day < 10){
        fDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
        print(fDate);
        print("fDate:::::::");
        dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }
      else {
        fDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
        print(fDate);
        print("fDate:::::::");
        dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }

    });
  }

}


