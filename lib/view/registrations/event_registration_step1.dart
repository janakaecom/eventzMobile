
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:eventz/view/widget/imput_square_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../configs/colors.dart';
import '../../configs/fonts.dart';
import '../../configs/images.dart';
import '../../model/payment_option_response.dart';
import '../widget/fl_text.dart';
import 'event_registration_step2.dart';

class EventRegistrationStep1 extends StatefulWidget {
  static var routeName = "/event_registration_step_1";

  const EventRegistrationStep1({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventRegistrationStep1State();
}

class _EventRegistrationStep1State extends State<EventRegistrationStep1> {

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
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController hostByController = new TextEditingController();

  FocusNode _passwordFocusNode;
  FocusNode _confirmPasswordFocusNode;
  Country _selectedCountry;
  Paymode selectedMode = Paymode();
  DateTime pickedDate = DateTime.now();
  List<Paymode> paymode = List();
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _dropDownValue;

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
                      displayText: "Event Registration",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      fontWeight: FontWeight.w600,
                      textSize: AppFonts.textFieldFontSize,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){},
                  child: Container(
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
                      textController: businessNameController,
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
                      textController: businessNameController,
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
                        textController: dateController,
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
                      textController: businessNameController,
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
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                               EventRegistrationStep2(
                              ),
                            ),
                          );
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
      dateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
    });
  }


}
