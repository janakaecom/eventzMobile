import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:eventz/view/widget/imput_square_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/all_event_response.dart' as all;
import '../../configs/colors.dart';
import 'package:get/get.dart';
import '../../configs/fonts.dart';
import '../../configs/images.dart';
import '../../model/all_event_response.dart';
import '../../model/event_register_request.dart' as rr;
import '../widget/fl_button.dart';
import '../widget/fl_text.dart';
import 'event_registration_step3.dart';

class EventRegistrationStep2 extends StatefulWidget {
  static var routeName = "/event_registration";

  final String onlineLink;
  final String eventName;
  final String eventDescription;
  final String eventDate;
  final int hostId;
  final bool isUpdate;
  final all.EventsResult event;
  final String eventTime;
  final String posterUrl;
  final String venue;
  final String mapReference;

  const EventRegistrationStep2(
      {Key key,
      this.onlineLink,
      this.eventName,
      this.eventDescription,
      this.eventDate,
      this.eventTime,
      this.venue,
      this.posterUrl,
      this.mapReference,
      this.hostId,
      this.event,
      this.isUpdate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventRegistrationStep2State();
}

class _EventRegistrationStep2State extends State<EventRegistrationStep2> {
  DateTime pickedDate = DateTime.now();
  final TextEditingController businessNameController =
      new TextEditingController();
  final TextEditingController address1Controller = new TextEditingController();
  final TextEditingController address2Controller = new TextEditingController();
  final TextEditingController countryController = new TextEditingController();
  final TextEditingController mobileNoController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController onlineLinkController =
      new TextEditingController();
  final TextEditingController closingDateController =
      new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController categoryController = new TextEditingController();
  final TextEditingController namesController = new TextEditingController();
  final TextEditingController confirmPasswordController =
      new TextEditingController();
  final TextEditingController countryCodeController =
      new TextEditingController();
  String _dropDownValue;
  bool isCheckedPhysical = false;
  bool isCheckedOnline = false;

  List<all.EventResourceObjectList> eventResourceObjectList = [];

  List<all.EventResourceObjectList> eventResourceObjectListUpdate = [];

  @override
  void initState() {
    super.initState();

    eventResourceObjectList.add(all.EventResourceObjectList(
        resCategory: "Category",
        resName: "Name",
        isActive: true,
        eventIdx: "1",
        eventResourceIdx: "1"));
    if (widget.isUpdate == true) {
      for (int i = 0; i < widget.event.eventResourceObjectList.length; i++) {
        eventResourceObjectListUpdate.add(all.EventResourceObjectList(
            resCategory: "Category",
            resName: "Name",
            isActive: true,
            eventIdx: widget.event.eventIdx.toString(),
            eventResourceIdx:
                widget.event.eventResourceObjectList[i].eventResourceIdx));

        eventResourceObjectListUpdate
            .add(widget.event.eventResourceObjectList[i]);
      }
      initialisation();
    }

    // eventFeeObjectList.add(er.EventFeeObjectList(catName: "Category",amount: "Amount", maxQuantity: "Quantity",eventFeeIdx: "0",eventIdx: "0"));
    //
    // if (widget.isUpdate == true){
    //
    //   for(int i = 0; i < widget.event.eventFeeObjectList.length; i++) {
    //     eventFeeObjectListUpdate.add(er.EventFeeObjectList(catName: "Category",amount: "Amount", maxQuantity: "Quantity",eventFeeIdx: widget.event.eventFeeObjectList[i].eventFeeIdx.toString(),eventIdx: widget.event.eventIdx.toString()));
    //     eventFeeObjectListUpdate.add(widget.event.eventFeeObjectList[i]);
    //   }
    //   initialisation();
    // }
  }

  void initialisation() {
    var cd = DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.event.closingDate));
    isCheckedPhysical = widget.event.eventModeIdx == 1 ? true : false;
    isCheckedOnline = widget.event.eventModeIdx == 2 ? true : false;
    onlineLinkController.text = widget.event.onlineLink.toString();
    closingDateController.text = cd;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Country> showCountryPickerSheett(BuildContext context,
      {Widget title,
      Widget cancelWidget,
      double cornerRadius: 35,
      bool focusSearchBox: false,
      double heightFactor: 0.9}) {
    assert(heightFactor <= 0.9 && heightFactor >= 0.4,
        'heightFactor must be between 0.4 and 0.9');
    return showModalBottomSheet<Country>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(cornerRadius),
                topRight: Radius.circular(cornerRadius))),
        builder: (_) {
          return Container(
            height: MediaQuery.of(context).size.height * heightFactor,
            child: Column(
              children: <Widget>[
                SizedBox(height: 16),
                Stack(
                  children: <Widget>[
                    cancelWidget ??
                        Positioned(
                          right: 8,
                          top: 0,
                          child: TextButton(
                              child: Text('Cancel'),
                              onPressed: () => Navigator.pop(context)),
                        ),
                    Center(
                      child: title ??
                          Text(
                            'Choose region',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Expanded(
                  child: CountryPickerWidget(
                    onSelected: (country) => Navigator.of(context).pop(country),
                  ),
                ),
              ],
            ),
          );
        });
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
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Container(
        // height: 800,
        width: double.infinity,
        decoration: const BoxDecoration(color: AppColors.kWhite),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    FLText(
                      displayText: "Event category :",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
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
                              hint: _dropDownValue == null
                                  ? Text('Dropdown')
                                  : Text(
                                      _dropDownValue,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: AppFonts.circularStd),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppFonts.circularStd),
                              items: ['Workshop', 'Concert'].map(
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: FLText(
                        displayText: "Event Mode :",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),
                    ),
                    SizedBox(
                      width: 27,
                    ),
                    Stack(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              // fillColor: Colors.purple,
                              value: isCheckedPhysical,
                              shape: CircleBorder(),
                              onChanged: (bool value) {
                                setState(() {
                                  isCheckedPhysical = value;
                                });
                              },
                            ),
                            FLText(
                              displayText: "Physical",
                              textColor: AppColors.kTextDark,
                              setToWidth: false,
                              textSize: AppFonts.textFieldFontSize14,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28),
                          child: Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                // fillColor: Colors.purple,
                                value: isCheckedOnline,
                                shape: CircleBorder(),
                                onChanged: (bool value) {
                                  setState(() {
                                    isCheckedOnline = value;
                                  });
                                },
                              ),
                              FLText(
                                displayText: "Online",
                                textColor: AppColors.kTextDark,
                                setToWidth: false,
                                textSize: AppFonts.textFieldFontSize14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 88),
                      child: FLText(
                        displayText: "Online Link :",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),
                    ),
                    SizedBox(
                      width: 46,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                            maxLength: 800,
                            maxLines: 5,
                            controller: onlineLinkController,
                            style: TextStyle(
                                color: AppColors.TextGray, fontSize: 13),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.TextGray.withOpacity(0.5),
                                    width: 1.5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.TextGray.withOpacity(0.5),
                                    width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.TextGray.withOpacity(0.5),
                                    width: 1.5),
                              ),
                            )),
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
                      displayText: "Closing Date :",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        readOnly: true,
                        textController: closingDateController,
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
                Row(
                  children: [
                    FLText(
                      displayText: "Presenters Information",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FLText(
                        displayText: "Presenter \nCategory",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),
                    ),
                    SizedBox(
                      width: 44,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: categoryController,
                        inputType: TextInputType.text,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: FLText(
                        displayText: "Presenter \nname",
                        textColor: AppColors.kTextDark,
                        setToWidth: false,
                        textSize: AppFonts.textFieldFontSize14,
                      ),
                    ),
                    SizedBox(
                      width: 44,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: namesController,
                        inputType: TextInputType.text,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if ((categoryController.text == "" || namesController.text == "") || (categoryController.text == null || namesController.text == null)) {
                              print('wewcd::::::::');
                            }
                              else{
                              if (widget.isUpdate == true) {
                                eventResourceObjectListUpdate.add(
                                    all.EventResourceObjectList(
                                        resCategory: categoryController.text ?? "-",
                                        resName: namesController.text ?? "-",
                                        isActive: true,
                                        eventIdx: "0",
                                        eventResourceIdx: "0"));
                              } else {
                                eventResourceObjectList.add(
                                    all.EventResourceObjectList(
                                        resCategory: categoryController.text ?? "-",
                                        resName: namesController.text ?? "-",
                                        isActive: true,
                                        eventIdx: "0",
                                        eventResourceIdx: "0"));
                              }
                            }
                            print("length:::::");
                            print(eventResourceObjectList.length);
                            categoryController.text = '';
                            namesController.text = '';
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.blue),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            child: FLText(
                              displayText: "Add",
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
                Visibility(
                  visible: eventResourceObjectList.length > 1 ||
                          eventResourceObjectListUpdate.length > 1
                      ? false
                      : true,
                  child: SizedBox(
                    height: 35,
                  ),
                ),
                Visibility(
                    visible: eventResourceObjectList.length > 1 ? true : false,
                    child: tableViewInsert()),
                widget.isUpdate == true
                    ? Visibility(
                        visible: eventResourceObjectListUpdate.length > 1
                            ? true
                            : false,
                        child: tableViewUpdate())
                    : SizedBox(),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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


                                        if(closingDateController.text == '' || closingDateController.text == null) {
                                          Get.snackbar('error', "The Closing date can't be empty.",
                                              colorText: AppColors.textRed,
                                              backgroundColor: AppColors.kWhite);
                                        }
                                        else {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EventRegistrationStep3(
                                                      eventModeId:
                                                      isCheckedPhysical == true ? 1 : 2,
                                                      onlineLink: onlineLinkController.text,
                                                      closingDate: closingDateController
                                                          .text,
                                                      list: eventResourceObjectList,
                                                      eventTime: widget.eventTime,
                                                      isUpdate: widget.isUpdate,
                                                      hostId: widget.hostId,
                                                      eventDate: widget.eventDate,
                                                      eventDescription: widget
                                                          .eventDescription,
                                                      eventName: widget.eventName,
                                                      posterUrl: widget.posterUrl,
                                                      venue: widget.venue,
                                                      mapReference: widget.mapReference,
                                                      event: widget.event,
                                                      eventResourceObjectListUpdateUpdate:
                                                      eventResourceObjectListUpdate),
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tableViewUpdate() {
    return Table(
      border: TableBorder.all(color: Colors.black),
      children: List<TableRow>.generate(
        eventResourceObjectListUpdate.length,
        (index) {
          return TableRow(children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: SizedBox(
                        width: 160,
                        child: Text(
                            eventResourceObjectListUpdate[index].resCategory,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: index == 0
                                    ? FontWeight.w600
                                    : FontWeight.w500))),
                  ),
                ],
              )
            ]),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: SizedBox(
                        width: 160,
                        child: Text(
                            eventResourceObjectListUpdate[index].resName,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: index == 0
                                    ? FontWeight.w600
                                    : FontWeight.w500))),
                  ),
                ],
              )
            ]),
          ]);
        },
        growable: false,
      ),
    );
  }

  Widget tableViewInsert() {
    return Table(
      border: TableBorder.all(color: Colors.black),
      children: List<TableRow>.generate(
        eventResourceObjectList.length,
        (index) {
          return TableRow(children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: SizedBox(
                        // width: 160,
                        child: Text(eventResourceObjectList[index].resCategory,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: index == 0
                                    ? FontWeight.w600
                                    : FontWeight.w500))),
                  ),
                ],
              )
            ]),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: SizedBox(
                        // width: 160,
                        child: Text(
                            eventResourceObjectList[index].resName.toString(),
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: index == 0
                                    ? FontWeight.w600
                                    : FontWeight.w500))),
                  ),
                ],
              )
            ]),
          ]);
        },
        growable: false,
      ),
    );
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
      if (pickedDate.month < 10 && pickedDate.day < 10) {
        closingDateController.text =
            "${pickedDate.year}-0${pickedDate.month}-0${pickedDate.day}";
      } else if (pickedDate.month < 10 && pickedDate.day > 10) {
        closingDateController.text =
            "${pickedDate.year}-0${pickedDate.month}-${pickedDate.day}";
      } else if (pickedDate.month > 10 && pickedDate.day < 10) {
        closingDateController.text =
            "${pickedDate.year}-${pickedDate.month}-0${pickedDate.day}";
      } else if (pickedDate.month < 10 && pickedDate.day < 10) {
        closingDateController.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      } else {
        closingDateController.text =
            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }
    });
  }
}
