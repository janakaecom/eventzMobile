
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:eventz/model/countries_response.dart';
import 'package:eventz/model/host_register_request.dart';
import 'package:eventz/view/widget/imput_square_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'package:eventz/view/BaseUI.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' as files;
import '../../api/api_service.dart';
import '../../configs/colors.dart';
import '../../configs/fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../configs/images.dart';
import '../../model/all_event_response.dart';
import '../../model/error_response.dart';
import '../../model/responses.dart';
import '../../model/register_request.dart';
import '../widget/fl_text.dart';
import 'dart:convert';
import 'package:image_cropper/image_cropper.dart';
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

class HostRegistration extends StatefulWidget {
  static var routeName = "/host_registration";

  const HostRegistration({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HostRegistrationState();
}

class _HostRegistrationState extends State<HostRegistration> with BaseUI{

  final TextEditingController businessNameController = new TextEditingController();
  final TextEditingController address1Controller = new TextEditingController();
  final TextEditingController address2Controller = new TextEditingController();
  final TextEditingController countryController = new TextEditingController();
  final TextEditingController mobileNoController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();
  final TextEditingController countryCodeController = new TextEditingController();
  FocusNode _passwordFocusNode;
  String logo;
  String _dropDownValue;
  int countryIdx;
  String imageUrl;
  FocusNode _confirmPasswordFocusNode;
  APIService apiService = APIService();
  List<Country> countryList = new List();
  List<String> countryListNames = new List();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    getAllCountries();
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      // drawer: AppDrawer(),
      // appBar: BaseAppBar(
      //     title: '',
      //     menuList: [],
      //     isDrawerShow: true,
      //     isBackShow: false),
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          width: 1000,
          decoration: const BoxDecoration(
          color: AppColors.kWhite
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 60),
            child: Column(
              children: [
                Row(
                  children: [
                    FLText(
                      displayText: "Host Registration",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    // imagePickerWithCrop();
                    uploadImage();

                  },
                  child:
                  imageUrl != null?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      imageUrl,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                  ):
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
                SizedBox(
                  height: 10,
                ),
                FLText(
                  displayText: "Business Logo",
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
                       displayText: "Business \nName",
                       textColor: AppColors.kTextDark,
                       setToWidth: false,
                       textSize: AppFonts.textFieldFontSize14,
                     ),
                     SizedBox(
                       width: 23,
                     ),
                     Expanded(
                       child: InputSquareTextField(
                         padding:const EdgeInsets.symmetric(vertical: 5),
                         readOnly: false,
                         textController: businessNameController,
                         inputType: TextInputType.text,
                         onChanged: (value) {
                         },
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
                      displayText: "Address 1",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: address1Controller,
                        inputType: TextInputType.text,
                        onChanged: (value) {
                        },
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
                      displayText: "Address 2",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: address2Controller,
                        inputType: TextInputType.text,
                        onChanged: (value) {
                        },
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
                      displayText: "Country :",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 26,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 38),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.TextGray.withOpacity(0.5),
                                width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: _dropDownValue == null
                                    ? Text('Select a country')
                                    : Text(
                                  _dropDownValue,
                                  style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
                                ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
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
                                      _dropDownValue = val.countryName;
                                          countryIdx = int.parse(val.eventVenue);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: InputSquareTextField(
                    //     hint: "E",
                    //     hintColor: AppColors.TextGray,
                    //     padding:const EdgeInsets.symmetric(vertical: 5),
                    //     readOnly: true,
                    //     textController: countryCodeController,
                    //     inputType: TextInputType.number,
                    //     onSuffixPress: _onPressedShowBottomSheet,
                    //     suffixIcon: Icon(Icons.chevron_right),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    FLText(
                      displayText: "Mobile No:",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        hint: "E",
                        hintColor: AppColors.TextGray,
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: mobileNoController,
                        inputType: TextInputType.number,
                        onChanged: (value) {
                        },
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
                      displayText: "Email \nAddress:",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 27,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        hint: "E",
                        hintColor: AppColors.TextGray,
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: emailController,
                        inputType: TextInputType.emailAddress,
                        onChanged: (value) {
                        },
                      ),
                    ),
                  ],
                ),



                SizedBox(
                  height: 180,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          hostRegisterCall();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                  color:  Colors.deepPurpleAccent
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                            child: FLText(
                              displayText: "Submit",
                              textColor: Colors.deepPurpleAccent,
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
    );
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
              for(int i = 0; i < countryList.length; i++){
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
            .child('images/imageName')
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

  ///host registration call
  void hostRegisterCall() {
    apiService.check().then((check) {
      HostRegisterRequest request = HostRegisterRequest(
        businessName: businessNameController.text,
        logoName: "edde.jpeg",
        logoPath: imageUrl,
        address1: address1Controller.text,
        address2: address2Controller.text,
        contactPerson: "Shanuka",
        countryIdx: countryIdx,
        emailAddress: emailController.text,
        hostIdx: 3,
        telephone: mobileNoController.text
      );
      showProgressbar(context);
      if (check) {
        apiService.hostRegister(request.toJson()).then((value) {
          hideProgressbar(context);

          if (value.statusCode == 200) {
            HostRegistrationResponse responseData =
            HostRegistrationResponse.fromJson(json.decode(value.body));
            Get.snackbar("Success", responseData.error,
                colorText: AppColors.textGreenLight,
                backgroundColor: AppColors.kWhite);
            // Get.off(LoginView());
          } else {
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
}
