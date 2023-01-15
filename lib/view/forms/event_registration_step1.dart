








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
import '../../model/host_register_request.dart';
import '../../model/payment_option_response.dart';
import '../../model/register_error_response.dart';
import '../../model/responses.dart';
import '../../utils/shared_storage.dart';
import '../widget/imput_square_text_field.dart';
import 'event_registration_step2.dart';

class EventRegistrationStep1 extends StatefulWidget {
  static var routeName = "/my_event";

  @override
  _EventRegistrationStep1State createState() => _EventRegistrationStep1State();
}

class _EventRegistrationStep1State extends State<EventRegistrationStep1> with BaseUI {

  final TextEditingController eventNameController = new TextEditingController();
  final TextEditingController eventDescriptionController = new TextEditingController();
  final TextEditingController eventTimeController = new TextEditingController();
  final TextEditingController eventDateController = new TextEditingController();
  final TextEditingController mapReferenceController = new TextEditingController();

  Paymode selectedMode = Paymode();
  String imageUrl;
  DateTime pickedDate = DateTime.now();
  List<Paymode> paymode = List();
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _dropDownValue;


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: BaseAppBar(
            title: "Event Registration",
            menuList: [],
            isDrawerShow: true,
            isBackShow: false),
        body: SingleChildScrollView(
          child: Container(
            // height: 500,
            // width: 1000,
            decoration: const BoxDecoration(
                color: AppColors.kWhite
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                      Image.network(
                        imageUrl,
                        height: 110,
                        width: 320,
                        fit: BoxFit.cover,
                      ):
                      Container(
                        height: 110,
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.15),
                        ),
                        child: Center(
                            child:
                            Icon(
                              Icons.photo,
                              size: 40,
                              color: Colors.grey,
                            )
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: (){},
                    //   child: Container(
                    //     height: 110,
                    //     width: 320,
                    //     decoration: BoxDecoration(
                    //         color: Colors.blue.withOpacity(0.15),
                    //     ),
                    //     child: Center(
                    //         child:
                    //      Icon(
                    //        Icons.photo,
                    //        size: 40,
                    //        color: Colors.grey,
                    //      )
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    FLText(
                      displayText: "Event Poster",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize16,
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FLText(
                              displayText: "Event Name",
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
                          textController: eventNameController,
                          inputType: TextInputType.number,
                          onChanged: (value) {
                          },
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
                              displayText: "Event Description",
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
                          textController: eventDescriptionController,
                          inputType: TextInputType.number,
                          onChanged: (value) {
                          },
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
                              displayText: "Host By",
                              textColor: AppColors.kTextDark,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.TextGray.withOpacity(0.5),
                                  width: 1.5
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: _dropDownValue == null
                                    ? Text('Dropdown')
                                    : Text(
                                  _dropDownValue,
                                  style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
                                ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
                                items: ['One', 'Two', 'Three'].map(
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
                                      _dropDownValue = val;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      children: [
                        FLText(
                          displayText: "Event Date :",
                          textColor: AppColors.kTextDark,
                          setToWidth: false,
                          textSize: AppFonts.textFieldFontSize14,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/images/my_events.png",
                          height: 30,
                          width: 30,
                          color: AppColors.TextGray,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InputSquareTextField(
                            padding:const EdgeInsets.symmetric(vertical: 5),
                            readOnly: false,
                            textController: eventDateController,
                            inputType: TextInputType.number,
                            onSuffixPress: (){
                              dateSelection();
                            },
                            suffixIcon: Icon(Icons.chevron_right),
                          ),
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
                              displayText: "Event Time",
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
                          textController: eventTimeController,
                          inputType: TextInputType.number,
                          onChanged: (value) {
                          },
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
                              displayText: "Venue",
                              textColor: AppColors.kTextDark,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: AppColors.TextGray.withOpacity(0.5),
                                  width: 1.5
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: _dropDownValue == null
                                    ? Text('Dropdown')
                                    : Text(
                                  _dropDownValue,
                                  style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
                                ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
                                items: ['One', 'Two', 'Three'].map(
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
                                      _dropDownValue = val;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 12,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FLText(
                              displayText: "Map Reference",
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
                          textController: mapReferenceController,
                          inputType: TextInputType.text,
                          onChanged: (value) {
                          },
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

                              if(eventNameController.text == '' || eventNameController.text == null) {
                                Get.snackbar('error', "The Event Name Can't be empty.",
                                    colorText: AppColors.textRed,
                                    backgroundColor: AppColors.kWhite);
                              }
                              else if(eventDescriptionController.text == '' || eventDescriptionController.text == null) {
                                Get.snackbar('error', "The Event Description Can't be empty.",
                                    colorText: AppColors.textRed,
                                    backgroundColor: AppColors.kWhite);
                              }
                              else if(eventDateController.text == '' || eventDateController.text == null) {
                                Get.snackbar('error', "The Event Time Can't be empty.",
                                    colorText: AppColors.textRed,
                                    backgroundColor: AppColors.kWhite);
                              }
                              // else if(widget.venue == '' || widget.venue == null) {
                              //   Get.snackbar('error', "The Event Name Can't be empty.",
                              //       colorText: AppColors.textRed,
                              //       backgroundColor: AppColors.kWhite);
                              // }
                              else {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventRegistrationStep2(
                                          eventName: eventNameController.text,
                                          eventDescription: eventDescriptionController.text,
                                          eventDate: eventDateController.text,
                                          eventTime: eventTimeController.text,
                                          posterUrl: imageUrl.toString(),
                                          mapReference: mapReferenceController.text,
                                        ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color:  Colors.deepPurpleAccent
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 24),
                                child: FLText(
                                  displayText: "Next",
                                  textColor: Colors.deepPurpleAccent,
                                  setToWidth: false,
                                  textSize: AppFonts.textFieldFontSize14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
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
  Future<void> dateSelection() async {
    String date;
    pickedDate = await showDatePicker(
        context: context,
        lastDate: DateTime(3000),
        initialDate: DateTime.now(),
        firstDate: DateTime.now());
    date = pickedDate.toString();

    // var formatter = DateFormat('dd MMM yyyy');
    // var formatted = formatter.format(DateTime.parse(date));
    // date = formatted;

    setState(() {

      if(pickedDate.month < 10 && pickedDate.day < 10){
        eventDateController.text = "${pickedDate.year}-0${pickedDate.month}-0${pickedDate.day}";
      }
      else if(pickedDate.month < 10 && pickedDate.day > 10){
        eventDateController.text = "${pickedDate.year}-0${pickedDate.month}-${pickedDate.day}";
      }
      else if(pickedDate.month > 10 && pickedDate.day < 10){
        eventDateController.text = "${pickedDate.year}-${pickedDate.month}-0${pickedDate.day}";
      }
      else if(pickedDate.month < 10 && pickedDate.day < 10){
        eventDateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }
      else {
        eventDateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }

    });
  }

}
