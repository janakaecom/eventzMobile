import 'dart:async';
import 'dart:convert';
import 'dart:io' as files;
import 'dart:math';
import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/error_response.dart';
import 'package:eventz/model/hosts_response.dart';
import 'package:eventz/model/login_response.dart';
import 'package:eventz/model/my_event_response.dart';
import 'package:eventz/model/venues_response.dart' as venues;
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
import '../../model/all_event_response.dart';
import '../../model/countries_response.dart';
import '../../model/host_register_request.dart';
import '../../model/payment_option_response.dart';
import '../../model/register_error_response.dart';
import '../../model/responses.dart';
import '../../model/venues_response.dart';
import '../../utils/shared_storage.dart';
import '../widget/imput_square_text_field.dart';
import 'event_registration_step2.dart';

class EventRegistrationStep1 extends StatefulWidget {
  final bool isUpdate;
  final EventsResult event;

  static var routeName = "/my_event";

  const EventRegistrationStep1({Key key, this.isUpdate, this.event})
      : super(key: key);

  @override
  _EventRegistrationStep1State createState() => _EventRegistrationStep1State();
}

class _EventRegistrationStep1State extends State<EventRegistrationStep1>
    with BaseUI {
  final TextEditingController eventNameController = new TextEditingController();
  final TextEditingController eventDescriptionController =
      new TextEditingController();
  final TextEditingController eventTimeController = new TextEditingController();
  final TextEditingController eventDateController = new TextEditingController();
  final TextEditingController mapReferenceController =
      new TextEditingController();
  String imageId;
  Paymode selectedMode = Paymode();
  String imageUrl;
  String seconds;
  int venueIdx;
  int hostIdx;
  DateTime pickedDate = DateTime.now();
  DateTime current = DateTime.now();
  List<Paymode> paymode = [];
  List<EventVenue> venuesList = [];
  Timer timer;
  List<Host> hostsList = [];
  List<String> venuesListNames = [];
  List<String> hostListNames = [];
  LoginResponse loginResponse;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      imageId = current.toString();
    });
    getProfileInfo();
    getAllHosts();
    getAllVenues();
    if (widget.isUpdate == true) {
      initialisation();
    }
  }

  void initialisation() {
    var ed =
        DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.event.eventDate));
    eventNameController.text = widget.event.eventName.toString();
    eventDescriptionController.text = widget.event.eventDescription.toString();
    eventTimeController.text = widget.event.eventTime.toString();
    eventDateController.text = ed;
    mapReferenceController.text = widget.event.venueMapReference ?? "";
    imageUrl = widget.event.artworkPath.toString();
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }

  String _hostDropDownValue;
  String dropDownValue;






  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    String imagePath;
    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image

      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = files.File(image.path);

      if (image != null) {
        //Upload to Firebase
        // setState(
        //       () {
        //     seconds = current.millisecond.toString() + current.microsecond.toString();
        //   },
        // );
        showProgressbar(context);
        print("imageId::::::::::::");
        print(DateTime.now());
        var snapshot = await _firebaseStorage.ref().child('images/${DateTime.now()}').putFile(file);
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
            decoration: const BoxDecoration(color: AppColors.kWhite),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // imagePickerWithCrop();
                        uploadImage();
                      },
                      child: imageUrl != null
                          ? Image.network(
                              imageUrl,
                              height: 110,
                              width: 320,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 110,
                              width: 320,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.15),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.photo,
                                size: 40,
                                color: Colors.grey,
                              )),
                            ),
                    ),
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          readOnly: false,
                          textController: eventNameController,
                          inputType: TextInputType.text,
                          onChanged: (value) {},
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          readOnly: false,
                          textController: eventDescriptionController,
                          inputType: TextInputType.text,
                          onChanged: (value) {},
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
                                  width: 1.5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: _hostDropDownValue == null
                                    ? Text('Select a host')
                                    : Text(
                                        _hostDropDownValue,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: AppFonts.circularStd),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppFonts.circularStd),
                                items: hostsList.map(
                                  (val) {
                                    return DropdownMenuItem<Host>(
                                      value: val,
                                      child: Text(val.hostName.toString()),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _hostDropDownValue = val.hostName;
                                      hostIdx = int.parse(val.hostIdx);
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            readOnly: true,
                            textController: eventDateController,
                            inputType: TextInputType.number,
                            onSuffixPress: () {
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          readOnly: false,
                          textController: eventTimeController,
                          inputType: TextInputType.text,
                          onChanged: (value) {},
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
                                  width: 1.5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: dropDownValue == null
                                    ? Text('Select a venue')
                                    : Text(
                                        dropDownValue,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: AppFonts.circularStd),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: AppFonts.circularStd),
                                items: venuesList.map(
                                  (val) {
                                    return DropdownMenuItem<EventVenue>(
                                      value: val,
                                      child: Text(val.eventVenue.toString()),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      dropDownValue = val.eventVenue;
                                      venueIdx = int.parse(val.venueIdx);
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          readOnly: false,
                          textController: mapReferenceController ?? "",
                          inputType: TextInputType.text,
                          onChanged: (value) {},
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

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 70),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        height: 50,
                                        width: 100,
                                        child: FLButton(
                                          borderRadius: 20,
                                          title: "Next".tr,
                                          onPressed: () async {

                                            if (eventNameController.text == '' ||
                                                eventNameController.text == null) {
                                              Get.snackbar(
                                                  'error', "The Event Name Can't be empty.",
                                                  colorText: AppColors.textRed,
                                                  backgroundColor: AppColors.kWhite);
                                            } else if (eventDescriptionController.text ==
                                                '' ||
                                                eventDescriptionController.text == null) {
                                              Get.snackbar('error',
                                                  "The Event Description Can't be empty.",
                                                  colorText: AppColors.textRed,
                                                  backgroundColor: AppColors.kWhite);
                                            } else if (eventTimeController.text == '' ||
                                                eventTimeController.text == null) {
                                              Get.snackbar(
                                                  'error', "The Event Time Can't be empty.",
                                                  colorText: AppColors.textRed,
                                                  backgroundColor: AppColors.kWhite);
                                            } else if (hostIdx == null || hostIdx == 0) {
                                              Get.snackbar(
                                                  'error', "The Host should be selected.",
                                                  colorText: AppColors.textRed,
                                                  backgroundColor: AppColors.kWhite);
                                            } else if (venueIdx == null || venueIdx == 0) {
                                              Get.snackbar(
                                                  'error', "The Venue should be selected.",
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
                                                        eventDescription:
                                                        eventDescriptionController.text,
                                                        eventDate: eventDateController.text,
                                                        venue: dropDownValue.toString(),
                                                        hostId: hostIdx,
                                                        isUpdate: widget.isUpdate,
                                                        eventTime: eventTimeController.text,
                                                        posterUrl: imageUrl.toString(),
                                                        mapReference: mapReferenceController.text,
                                                        event: widget.event,
                                                      ),
                                                ),
                                              );
                                            }

                                          },
                                          backgroundColor: AppColors.buttonBlue,
                                          titleFontColor: AppColors.kWhite,
                                          borderColor: AppColors.buttonBlue,
                                          minWidth: 100,
                                          height: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
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

  getProfileInfo() async {
    try {
      loginResponse =
          LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
    } catch (Excepetion) {
      print(Excepetion.toString());
    }
  }

  ///get all hosts from API
  void getAllHosts() {
    print("hosts load");
    apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getAllHosts(loginResponse.result.userIdx).then((value) {
          hideProgressbar(context);
          if (value.statusCode == 200) {
            HostsResponse responseData =
                HostsResponse.fromJson(json.decode(value.body));
            setState(() {
              hostsList = responseData.host;
              print("hostsList::::::::");
              print(responseData.host);
              for (int i = 0; i < hostsList.length; i++) {
                hostListNames.add(hostsList[i].hostName);
              }
              print("hostsListNames:::::::");
              print(hostsList);
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

  ///get all venues from API
  void getAllVenues() {
    print("venues load");
    apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getAllVenues().then((value) {
          hideProgressbar(context);
          if (value.statusCode == 200) {
            VenueResponse responseData =
                VenueResponse.fromJson(json.decode(value.body));
            setState(() {
              venuesList = responseData.eventVenue;
              print("venueList::::::::");
              print(responseData.eventVenue);
              for (int i = 0; i < venuesList.length; i++) {
                venuesListNames.add(venuesList[i].eventVenue);
              }
              print("venueListNames:::::::");
              print(venuesListNames);
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
      if (pickedDate.month < 10 && pickedDate.day < 10) {
        eventDateController.text =
            "${pickedDate.year}-0${pickedDate.month}-0${pickedDate.day}";
      } else if (pickedDate.month < 10 && pickedDate.day > 10) {
        eventDateController.text =
            "${pickedDate.year}-0${pickedDate.month}-${pickedDate.day}";
      } else if (pickedDate.month > 10 && pickedDate.day < 10) {
        eventDateController.text =
            "${pickedDate.year}-${pickedDate.month}-0${pickedDate.day}";
      } else if (pickedDate.month < 10 && pickedDate.day < 10) {
        eventDateController.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      } else {
        eventDateController.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }
    });
  }
}
