
import 'dart:convert';
import 'dart:io' as files;
import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/configs/images.dart';
import 'package:eventz/model/error_response.dart';
import 'package:eventz/model/hosts_response.dart';
import 'package:eventz/model/login_response.dart';
import 'package:eventz/model/my_event_response.dart';
import 'package:eventz/utils/constants.dart';
import 'package:eventz/view/BaseUI.dart';
import 'package:eventz/view/forms/event_registration_step1.dart';
import 'package:eventz/view/myEvent/my_event_details.dart';
import 'package:eventz/view/widget/app_bar.dart';
import 'package:eventz/view/widget/app_drawer.dart';
import 'package:eventz/view/widget/fl_button.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../model/all_event_response.dart';

class UpdateEvents extends StatefulWidget {
  static var routeName = "/my_event";

  @override
  _UpdateEventsState createState() => _UpdateEventsState();
}

class _UpdateEventsState extends State<UpdateEvents> with BaseUI {

  String _hostDropDownValue;
  int hostIdx;
  List<EventsResult> eventList;
  DateTime pickedDate = DateTime.now();
  List<Host> hostsList = [];
  List<String> hostListNames = [];
  LoginResponse loginResponse ;


  @override
  void initState() {
    super.initState();
    getProfileInfo();
    getAllHosts();
  }


  getProfileInfo() async {
    try {
      loginResponse = LoginResponse.fromJson(await sharedPref.read(ShardPrefKey.USER));
    } catch (Excepetion) {
      print(Excepetion.toString());
    }

  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: BaseAppBar(
            title: "Update Events",
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
              child: Column(
                children: [


                  Row(
                    children: [
                      FLText(
                        displayText: "Host :",
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
                                  hint: _hostDropDownValue == null
                                      ? Text('Select a host')
                                      : Text(
                                    _hostDropDownValue,
                                    style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
                                  ),
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: TextStyle(color: Colors.black,fontFamily: AppFonts.circularStd),
                                  items: hostsList.map(
                                        (val) {
                                      return DropdownMenuItem<Host>(
                                        value: val,
                                        child: Text(val.hostName.toString()),
                                      );
                                    },
                                  ).toList(),
                                  onTap: (){
                                    setState(
                                          () {

                                      },
                                    );

                                  },
                                  onChanged: (val) {
                                    setState(
                                          () {
                                        _hostDropDownValue = val.hostName;
                                        hostIdx = int.parse(val.countryCodeId);
                                        downloadAllEvents();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),



                ],
              ),
                  SizedBox(
                    height: 15,
                  ),
                  eventList == null ?
                  SizedBox():
                  Expanded(
                    child: ListView.builder(
                        itemCount: eventList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _eventRow(index);
                        }),
                  ),
                  SizedBox(
                    height: 180,
                  ),
            ]
            ),),
          ),
        ));
  }


  ///download all event from API
  void downloadAllEvents() {
    print("Event load");
    apiService.check().then((check) {
      showProgressbar(context);
      if (check) {
        apiService.getAllEventsCreatedByHost(hostIdx).then((value) {
          hideProgressbar(context);

          if (value.statusCode == 200) {
            // List<dynamic> responseData = jsonDecode(value.body);
            AllEventResponse responseData = AllEventResponse.fromJson(json.decode(value.body));
            setState(() {
              eventList = responseData.result;
            });
          } else {
            ErrorResponse responseData = ErrorResponse.fromJson(json.decode(value.body));
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


  ///Event row view in list-view
  _eventRow(int index) {
    var item = eventList;
    String apiDate = item[index].eventDate.split(" ")[0];
    String year = "";
    String date = "";
    String month = "";
    try {
      year = apiDate.split("/")[2];
      date = apiDate.split("/")[1];
      month = helper.getMonthShortName(int.parse(apiDate.split("/")[0]) - 1);
    } catch (e) {
      date = "N/A";
    }

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: AppColors.kWhite)),
      child:

      Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: AppColors.kWhite)),
            padding: const EdgeInsets.only(top: 0, left: 0.0, right: 0.0),
            child:
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(children: [
                Image.network(
                  item[index].artworkPath,
                  width: Get.width,
                  height: 200,
                  fit: BoxFit.fill,
                ),

                Container(
                  padding: const EdgeInsets.only(
                      top: 120, left: 15, right: 10, bottom: 10),
                  width: Get.width,
                  height: 200,
                  color: AppColors.appDark.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          // Get.to(EventDetails(), arguments: item);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventRegistrationStep1(
                                event: eventList[index],
                                isUpdate: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, right: 10),
                          decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              border: Border.all(
                                color: AppColors.kWhite,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          alignment: Alignment.topRight,
                          height: 45,
                          width: 45,
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              size: 28,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // priceTag(item),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 20,top: 115),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              item[index].eventName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.kWhite,
                                fontFamily: AppFonts.circularStd,
                                fontSize: AppFonts.textFieldFontSize,
                            ),
                          ),
                          FLText(
                            displayText: item[index].hostName,
                            textColor: AppColors.kWhite,
                            setToWidth: false,
                            textSize: AppFonts.textFieldFontSize14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                mapIconWhite,
                                width: 15,
                                height: 15,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              FLText(
                                displayText:item[index].eventVenue,
                                textColor: AppColors.kWhite,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          // _rowBottom(item[index]),
        ],
      ),
    );
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
            HostsResponse responseData = HostsResponse.fromJson(json.decode(value.body));
            setState(() {
              hostsList = responseData.host;
              print("hostsList::::::::");
              print(responseData.host);
              for(int i = 0; i < hostsList.length; i++){
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

}
