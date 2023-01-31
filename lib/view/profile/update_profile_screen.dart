







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
import 'package:permission_handler/permission_handler.dart';

import '../../api/api_service.dart';
import '../../model/countries_response.dart';
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
  final TextEditingController mobileNoController = new TextEditingController();
  final TextEditingController occupationController = new TextEditingController();
  final TextEditingController workPlaceController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController emgContactNumberController = new TextEditingController();
  final TextEditingController emgContactNameController = new TextEditingController();
  FocusNode _passwordFocusNode;
  String logo;
  DateTime pickedDate = DateTime.now();
  String _userName = "";
  String dropDownTitleValue;
  String dropDownGenderValue;
  String dropDownCountryValue;
  int countryIdx;
  String imageUrl;
  FocusNode _confirmPasswordFocusNode;
  APIService apiService = APIService();
  List<Country> countryList = new List();
  List<String> countryListNames = new List();
  SharedPref sharedPref = SharedPref();
  LoginResponse loginResponse ;
  ur.Result profileData;
  int genderIdx;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    getProfileInfo();
   // initialization();
    getAllCountries();

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
              imageUrl = profileData.profilePicURL;
              dropDownTitleValue = profileData.title;
              dropDownGenderValue = profileData.genderId == 1 ? "Female":"Male";
              firstNameController.text = profileData.firstName;
              lastNameController.text = profileData.lastName;
              mobileNoController.text = profileData.mobileNo;
              nicController.text = profileData.nic;
              dateController.text = profileData.dob;
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

  //
  // Future initialization() async {
  //   print("profileData.result.firstName::::::");
  //   print(profileData.ur.result.firstName);
  //   firstNameController.text = profileData.result.firstName;
  //   lastNameController.text = profileData.result.lastName;
  //   passportNoController.text = profileData.result.mobileNo;
  // }
  //

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
    if(dropDownTitleValue == null || dropDownTitleValue == "") {
      Get.snackbar('error'.tr, "The Title should be selected",
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
    else if(genderIdx == null) {
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
        ProfileUpdateRequest request = ProfileUpdateRequest(
            title: dropDownTitleValue.toString(),
            genderId: dropDownGenderValue.toString() == "Male" ? 1 : 2,
            nIC: nicController.text,
            passport: passportNoController.text,
            address: addressController.text,
            dOB: dateController.text,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: BaseAppBar(
            title: "Profile Update",
            menuList: [],
            isDrawerShow: true,
            isBackShow: false),
        body: Container(
          height: 1000,
          width: 1000,
          decoration: const BoxDecoration(
              color: AppColors.kWhite
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                    },
                    child: InkWell(
                      onTap: () {
                        // imagePickerWithCrop();
                        uploadImage();
                      },
                      child:
                      imageUrl != null ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          imageUrl,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ) :
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(60)
                        ),
                        child: Center(
                            child:
                            // logo != null?
                            // Image.file(
                            //   files.File(logo),
                            //   width: 100,
                            //   height: 100,
                            // ):

                            Image.asset(
                              menuUser,
                              width: 28,
                              height: 28,
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FLText(
                    displayText: "Profile Picture",
                    textColor: AppColors.kTextDark,
                    setToWidth: false,
                    textSize: AppFonts.textFieldFontSize16,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "Title",
                        textColor: AppColors.kTextDark,
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
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: dropDownTitleValue == null
                              ? Text("Mr")
                              : Text(
                            dropDownTitleValue,
                            style: TextStyle(color: Colors.black,
                                fontFamily: AppFonts.circularStd),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black,
                              fontFamily: AppFonts.circularStd),
                          items: ["Mr", "Mrs"].map(
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
                                dropDownTitleValue = val;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "First Name",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InputSquareTextField(
                    readOnly: false,
                    textController: firstNameController,
                    inputType: TextInputType.text,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "Last Name",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InputSquareTextField(
                    readOnly: false,
                    textController: lastNameController,
                    inputType: TextInputType.text,
                    onChanged: (value) {},
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "Gender",
                        textColor: AppColors.kTextDark,
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
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: dropDownGenderValue == null
                              ? Text("Male")
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "NIC",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InputSquareTextField(
                    readOnly: false,
                    textController: nicController,
                    inputType: TextInputType.text,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "DOB",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8,
                  ),
                  InputSquareTextField(
                    readOnly: false,
                    textController: dateController,
                    inputType: TextInputType.number,
                    onSuffixPress: () {
                      dateSelection();
                    },
                    suffixIcon: Icon(Icons.chevron_right),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "Passport No",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 8,
                  ),
                  InputSquareTextField(
                    // hint: "E",
                    hintColor: AppColors.TextGray,
                    readOnly: false,
                    textController: passportNoController,
                    inputType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "Address :",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InputSquareTextField(
                    hintColor: AppColors.TextGray,
                    readOnly: false,
                    textController: addressController,
                    inputType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      FLText(
                        displayText: "Country",
                        textColor: AppColors.kTextDark,
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
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: dropDownCountryValue == null
                              ? Text('Select a country')
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "Occupation",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  InputSquareTextField(
                    hintColor: AppColors.TextGray,
                    readOnly: false,
                    textController: occupationController,
                    inputType: TextInputType.number,
                    onChanged: (value) {},
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      FLText(
                        displayText: "Work Place",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InputSquareTextField(
                    hintColor: AppColors.TextGray,
                    readOnly: false,
                    textController: workPlaceController,
                    inputType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      FLText(
                        displayText: "Emg Contact Name",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InputSquareTextField(
                    hintColor: AppColors.TextGray,
                    readOnly: false,
                    textController: emgContactNameController,
                    inputType: TextInputType.number,
                    onChanged: (value) {},
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      FLText(
                        displayText: "Emg Contact Number",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),

                  InputSquareTextField(
                    hintColor: AppColors.TextGray,

                    readOnly: false,
                    textController: emgContactNumberController,
                    inputType: TextInputType.number,
                    onChanged: (value) {},
                  ),
                  SizedBox(
                    height: 12,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              updateProfileCall();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.blue
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: FLText(
                                  displayText: "Update Profile",
                                  textColor: Colors.white,
                                  setToWidth: false,
                                  textSize: AppFonts.textFieldFontSize14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  ///get all countries from API
  void getAllCountries() {
    print("country load");
    apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getAllCountries().then((value) {
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

    // var formatter = DateFormat('dd MMM yyyy');
    // var formatted = formatter.format(DateTime.parse(date));
    // date = formatted;

    setState(() {

      if(pickedDate.month < 10 && pickedDate.day < 10){
        dateController.text = "${pickedDate.year}-0${pickedDate.month}-0${pickedDate.day}";
      }
      else if(pickedDate.month < 10 && pickedDate.day > 10){
        dateController.text = "${pickedDate.year}-0${pickedDate.month}-${pickedDate.day}";
      }
      else if(pickedDate.month > 10 && pickedDate.day < 10){
        dateController.text = "${pickedDate.year}-${pickedDate.month}-0${pickedDate.day}";
      }
      else if(pickedDate.month < 10 && pickedDate.day < 10){
        dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }
      else {
        dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }

    });
  }

}













//
//
// import 'package:country_calling_code_picker/country_code_picker.dart';
// import 'package:eventz/model/countries_response.dart';
// import 'package:eventz/model/host_register_request.dart';
// import 'package:eventz/view/widget/imput_square_text_field.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:eventz/view/BaseUI.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:io' as files;
// import '../../api/api_service.dart';
// import '../../configs/colors.dart';
// import '../../configs/fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../configs/images.dart';
// import '../../model/updateProfileResponse.dart';
// import '../../model/all_event_response.dart';
// import '../../model/error_response.dart';
// import '../../model/responses.dart';
// import '../../model/login_response.dart';
// import '../../model/register_request.dart';
// import '../../model/update_profile_request.dart';
// import '../../utils/constants.dart';
// import '../../utils/shared_storage.dart';
// import '../widget/fl_text.dart';
// import 'dart:convert';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:eventz/configs/colors.dart';
// import 'package:eventz/configs/fonts.dart';
// import 'package:eventz/configs/images.dart';
// import 'package:eventz/model/register_error_response.dart';
// import 'package:eventz/model/register_request.dart';
// import 'package:eventz/model/register_success_response.dart';
// import 'package:eventz/view/BaseUI.dart';
// import 'package:eventz/view/login/login_view.dart';
// import 'package:eventz/view/widget/fl_button.dart';
// import 'package:eventz/view/widget/fl_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class UpdateProfileScreen extends StatefulWidget {
//   static var routeName = "/update_profile_screen";
//
//   const UpdateProfileScreen({Key key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _UpdateProfileScreenState();
// }
//
// class _UpdateProfileScreenState extends State<UpdateProfileScreen> with BaseUI{
//
//   final TextEditingController firstNameController = new TextEditingController();
//   final TextEditingController lastNameController = new TextEditingController();
//   final TextEditingController dateController = new TextEditingController();
//   final TextEditingController addressController = new TextEditingController();
//   final TextEditingController nicController = new TextEditingController();
//   final TextEditingController passportNoController = new TextEditingController();
//   final TextEditingController mobileNoController = new TextEditingController();
//   final TextEditingController occupationController = new TextEditingController();
//   final TextEditingController workPlaceController = new TextEditingController();
//   final TextEditingController passwordController = new TextEditingController();
//   final TextEditingController emgContactNumberController = new TextEditingController();
//   final TextEditingController emgContactNameController = new TextEditingController();
//   FocusNode _passwordFocusNode;
//   String logo;
//   DateTime pickedDate = DateTime.now();
//   String _userName = "";
//   String _dropDownTitleValue;
//   String _dropDownGenderValue;
//   String _dropDownCountryValue;
//   int countryIdx;
//   String imageUrl;
//   FocusNode _confirmPasswordFocusNode;
//   APIService apiService = APIService();
//   List<Country> countryList = new List();
//   List<String> countryListNames = new List();
//   SharedPref sharedPref = SharedPref();
//   LoginResponse profileData;
//
//   @override
//   void initState() {
//     getProfileInfo();
//     super.initState();
//     _passwordFocusNode = FocusNode();
//     getAllCountries();
//   }
//
//   Future<void> initialization() async {
//     print("profileData.result.firstName::::::");
//     print(profileData.result.firstName);
//     firstNameController.text = profileData.result.firstName;
//     lastNameController.text = profileData.result.lastName;
//     passportNoController.text = profileData.result.mobileNo;
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//
//   getProfileInfo() async {
//     try {
//       profileData = LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
//     } catch (Excepetion) {
//       print(Excepetion.toString());
//     }
//
//     initialization();
//   }
//
//   ///host registration call
//   void updateProfileCall() {
//     apiService.check().then((check) {
//       ProfileUpdateRequest request = ProfileUpdateRequest(
//           title: _dropDownTitleValue.toString(),
//           genderId: _dropDownGenderValue.toString() == "Male" ? 1:2,
//           NIC: nicController.text,
//           passportNo: passportNoController.text,
//           address: addressController.text,
//           dob: dateController.text,
//           occupation: occupationController.text,
//           workPlace: workPlaceController.text,
//           emgContactName: emgContactNumberController.text,
//           emgContactNo: emgContactNumberController.text,
//           profilePicURL: imageUrl,
//           userTypeIdx: profileData.result.userTypeIdx,
//           firstName: firstNameController.text,
//           lastName: lastNameController.text,
//           mobileNo: mobileNoController.text,
//           countryID: countryIdx
//       );
//       showProgressbar(context);
//       if (check) {
//         apiService.userUpdate(request.toJson()).then((value) {
//           hideProgressbar(context);
//
//           if (value.statusCode == 200) {
//             UpdateProfileResponse responseData =
//             UpdateProfileResponse.fromJson(json.decode(value.body));
//             Get.snackbar("Success", responseData.result,
//                 colorText: AppColors.textGreenLight,
//                 backgroundColor: AppColors.kWhite);
//             // Get.off(LoginView());
//           } else {
//             RegisterErrorResponse responseData =
//             RegisterErrorResponse.fromJson(json.decode(value.body));
//             Get.snackbar('error'.tr, responseData.message,
//                 colorText: AppColors.textRed,
//                 backgroundColor: AppColors.kWhite);
//           }
//         });
//       } else {
//         hideProgressbar(context);
//         helper.showAlertView(context, 'no_internet'.tr, () {}, 'ok'.tr);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.kWhite,
//       // drawer: AppDrawer(),
//       // appBar: BaseAppBar(
//       //     title: '',
//       //     menuList: [],
//       //     isDrawerShow: true,
//       //     isBackShow: false),
//       body: Container(
//         height: 1000,
//         width: 1000,
//         decoration: const BoxDecoration(
//             color: AppColors.kWhite
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 60),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "My Profile",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 InkWell(
//                   onTap: (){
//
//                   },
//                   child: InkWell(
//                     onTap: (){
//                       // imagePickerWithCrop();
//                       uploadImage();
//
//                     },
//                     child:
//                     imageUrl != null?
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(60),
//                       child: Image.network(
//                         imageUrl,
//                         width: 110,
//                         height: 110,
//                         fit: BoxFit.cover,
//                       ),
//                     ):
//                     Container(
//                       height: 110,
//                       width: 110,
//                       decoration: BoxDecoration(
//                           color: Colors.blue.withOpacity(0.15),
//                           borderRadius: BorderRadius.circular(60)
//                       ),
//                       child: Center(
//                           child:
//                           // logo != null?
//                           // Image.file(
//                           //   files.File(logo),
//                           //   width: 100,
//                           //   height: 100,
//                           // ):
//
//                           Image.asset(
//                             menuUser,
//                             width: 28,
//                             height: 28,
//                             fit: BoxFit.cover,
//                           )
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 FLText(
//                   displayText: "Profile Picture",
//                   textColor: AppColors.kTextDark,
//                   setToWidth: false,
//                   textSize: AppFonts.textFieldFontSize16,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Title :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 23,
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 38),
//                         child: Container(
//                           height: 40,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: AppColors.TextGray.withOpacity(0.5),
//                                 width: 1.5,
//                               ),
//                               borderRadius: BorderRadius.circular(5)
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 hint: _dropDownTitleValue == null
//                                     ? Text("Mr")
//                                     : Text(
//                                   _dropDownTitleValue,
//                                   style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
//                                 ),
//                                 isExpanded: true,
//                                 iconSize: 30.0,
//                                 style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
//                                 items: ["Mr","Mrs"].map(
//                                       (val) {
//                                     return DropdownMenuItem<String>(
//                                       value: val,
//                                       child: Text(val),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged: (val) {
//                                   setState(
//                                         () {
//                                           _dropDownTitleValue = val;
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "First Name :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 22,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: firstNameController,
//                         inputType: TextInputType.text,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Last Name :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: lastNameController,
//                         inputType: TextInputType.text,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Gender :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 26,
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 38),
//                         child: Container(
//                           height: 40,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: AppColors.TextGray.withOpacity(0.5),
//                                 width: 1.5,
//                               ),
//                               borderRadius: BorderRadius.circular(5)
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 hint: _dropDownGenderValue == null
//                                     ? Text("Male")
//                                     : Text(
//                                   _dropDownGenderValue,
//                                   style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
//                                 ),
//                                 isExpanded: true,
//                                 iconSize: 30.0,
//                                 style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
//                                 items: ["Male","Female"].map(
//                                       (val) {
//                                     return DropdownMenuItem<String>(
//                                       value: val,
//                                       child: Text(val),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged: (val) {
//                                   setState(
//                                         () {
//                                       _dropDownGenderValue = val;
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Expanded(
//                     //   child: InputSquareTextField(
//                     //     hint: "E",
//                     //     hintColor: AppColors.TextGray,
//                     //     padding:const EdgeInsets.symmetric(vertical: 5),
//                     //     readOnly: true,
//                     //     textController: countryCodeController,
//                     //     inputType: TextInputType.number,
//                     //     onSuffixPress: _onPressedShowBottomSheet,
//                     //     suffixIcon: Icon(Icons.chevron_right),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Mobile No :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: mobileNoController,
//                         inputType: TextInputType.text,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "NIC :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: nicController,
//                         inputType: TextInputType.text,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "DOB :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Image.asset(
//                       "assets/images/my_events.png",
//                       height: 30,
//                       width: 30,
//                       color: AppColors.TextGray,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: dateController,
//                         inputType: TextInputType.number,
//                         onSuffixPress: (){
//                           dateSelection();
//                         },
//                         suffixIcon: Icon(Icons.chevron_right),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Passport No :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 16,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         // hint: "E",
//                         hintColor: AppColors.TextGray,
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: passportNoController,
//                         inputType: TextInputType.number,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Address :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 27,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         hintColor: AppColors.TextGray,
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: addressController,
//                         inputType: TextInputType.number,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//
//
//
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Country :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 27,
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 38),
//                         child: Container(
//                           height: 40,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: AppColors.TextGray.withOpacity(0.5),
//                                 width: 1.5,
//                               ),
//                               borderRadius: BorderRadius.circular(5)
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 hint: _dropDownCountryValue == null
//                                     ? Text('Select a country')
//                                     : Text(
//                                   _dropDownCountryValue,
//                                   style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
//                                 ),
//                                 isExpanded: true,
//                                 iconSize: 30.0,
//                                 style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
//                                 items: countryList.map(
//                                       (val) {
//                                     return DropdownMenuItem<Country>(
//                                       value: val,
//                                       child: Text(val.countryName.toString()),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged: (val) {
//                                   setState(
//                                         () {
//                                       print("val::::::::");
//                                       print(val.countryName);
//                                       _dropDownCountryValue = val.countryName;
//                                       countryIdx = int.parse(val.countryIdx);
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//
//
//
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Occupation :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 27,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         hintColor: AppColors.TextGray,
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: occupationController,
//                         inputType: TextInputType.number,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//
//
//
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Work Place :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 27,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         hintColor: AppColors.TextGray,
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: workPlaceController,
//                         inputType: TextInputType.number,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//
//
//
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Emg Contact \nname :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 27,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         hintColor: AppColors.TextGray,
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: emgContactNameController,
//                         inputType: TextInputType.number,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: [
//                     FLText(
//                       displayText: "Emg Contact \nnumber :",
//                       textColor: AppColors.kTextDark,
//                       setToWidth: false,
//                       textSize: AppFonts.textFieldFontSize14,
//                     ),
//                     SizedBox(
//                       width: 27,
//                     ),
//                     Expanded(
//                       child: InputSquareTextField(
//                         hintColor: AppColors.TextGray,
//                         padding:const EdgeInsets.symmetric(vertical: 5),
//                         readOnly: false,
//                         textController: emgContactNumberController,
//                         inputType: TextInputType.number,
//                         onChanged: (value) {
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         InkWell(
//                           onTap: (){
//                             updateProfileCall();
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(3),
//                                 color: Colors.blue
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
//                               child: FLText(
//                                 displayText: "Update Profile",
//                                 textColor: Colors.white,
//                                 setToWidth: false,
//                                 textSize: AppFonts.textFieldFontSize14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   ///get all countries from API
//   void getAllCountries() {
//     print("country load");
//     apiService.check().then((check) {
//       showProgressbar(context);
//       if (check) {
//         apiService.getAllCountries().then((value) {
//           hideProgressbar(context);
//           if (value.statusCode == 200) {
//             CountriesResponse responseData =
//             CountriesResponse.fromJson(json.decode(value.body));
//             setState(() {
//               countryList = responseData.country;
//               print("countryList::::::::");
//               print(countryList);
//               for(int i = 0; i < countryList.length; i++){
//                 countryListNames.add(countryList[i].countryName);
//               }
//               print("countryListNames:::::::");
//               print(countryListNames);
//             });
//           } else {
//             ErrorResponse responseData =
//             ErrorResponse.fromJson(json.decode(value.body));
//             Get.snackbar('error'.tr, responseData.message,
//                 colorText: AppColors.textRed,
//                 snackPosition: SnackPosition.TOP,
//                 borderRadius: 0,
//                 borderWidth: 2,
//                 margin: EdgeInsets.only(left: 20, right: 20, top: 30),
//                 backgroundColor: AppColors.bgGreyLight);
//           }
//         });
//       } else {
//         hideProgressbar(context);
//         helper.showAlertView(context, 'no_internet'.tr, () {}, 'ok'.tr);
//       }
//     });
//   }
//
//   uploadImage() async {
//     final _firebaseStorage = FirebaseStorage.instance;
//     final _imagePicker = ImagePicker();
//     PickedFile image;
//     //Check Permissions
//     await Permission.photos.request();
//
//     var permissionStatus = await Permission.photos.status;
//
//     if (permissionStatus.isGranted){
//       //Select Image
//       image = await _imagePicker.getImage(source: ImageSource.gallery);
//       var file = files.File(image.path);
//
//       if (image != null){
//         //Upload to Firebase
//         showProgressbar(context);
//         var snapshot = await _firebaseStorage.ref()
//             .child('images/imageName')
//             .putFile(file);
//         var downloadUrl = await snapshot.ref.getDownloadURL();
//         setState(() {
//           imageUrl = downloadUrl;
//         });
//         hideProgressbar(context);
//       } else {
//         print('No Image Path Received');
//         hideProgressbar(context);
//       }
//     } else {
//       print('Permission not granted. Try Again with permission access');
//     }
//   }
//
//   Future<void> dateSelection() async {
//     String date;
//     pickedDate = await showDatePicker(
//         context: context,
//         lastDate: DateTime(3000),
//         initialDate: DateTime.now(),
//         firstDate: DateTime(1500));
//     date = pickedDate.toString();
//
//     // var formatter = DateFormat('dd MMM yyyy');
//     // var formatted = formatter.format(DateTime.parse(date));
//     // date = formatted;
//
//     setState(() {
//
//       if(pickedDate.month < 10 && pickedDate.day < 10){
//         dateController.text = "${pickedDate.year}-0${pickedDate.month}-0${pickedDate.day}";
//       }
//       else if(pickedDate.month < 10 && pickedDate.day > 10){
//         dateController.text = "${pickedDate.year}-0${pickedDate.month}-${pickedDate.day}";
//       }
//       else if(pickedDate.month > 10 && pickedDate.day < 10){
//         dateController.text = "${pickedDate.year}-${pickedDate.month}-0${pickedDate.day}";
//       }
//       else if(pickedDate.month < 10 && pickedDate.day < 10){
//         dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
//       }
//       else {
//         dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
//       }
//
//     });
//   }
//
//
//
// }
