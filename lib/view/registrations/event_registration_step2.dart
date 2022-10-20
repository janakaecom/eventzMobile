
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:eventz/view/registrations/event_registration_step3.dart';
import 'package:eventz/view/widget/imput_square_text_field.dart';
import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../../configs/fonts.dart';
import '../../configs/images.dart';
import '../widget/fl_text.dart';

class EventRegistrationStep2 extends StatefulWidget {
  static var routeName = "/event_registration";

  const EventRegistrationStep2({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventRegistrationStep2State();
}

class _EventRegistrationStep2State extends State<EventRegistrationStep2> {

  DateTime pickedDate = DateTime.now();
  final TextEditingController businessNameController = new TextEditingController();
  final TextEditingController address1Controller = new TextEditingController();
  final TextEditingController address2Controller = new TextEditingController();
  final TextEditingController countryController = new TextEditingController();
  final TextEditingController mobileNoController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController closingDateController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();
  final TextEditingController countryCodeController = new TextEditingController();
  FocusNode _passwordFocusNode;
  FocusNode _confirmPasswordFocusNode;
  Country _selectedCountry;

  String _dropDownValue;
  bool isCheckedPhysical =  false;
  bool isCheckedOnline =  false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {

    super.dispose();
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheett(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
        countryCodeController.text = country.name.toString();
      });
    }
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
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          width: 1000,
          decoration: const BoxDecoration(
              color: AppColors.kWhite
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 100),
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
                      child:
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
                              style: TextStyle(color: AppColors.TextGray,fontSize: 13),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  counterText: '',
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.TextGray.withOpacity(0.5), width: 1.5),),
                                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.TextGray.withOpacity(0.5), width: 1.5),),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.TextGray.withOpacity(0.5), width: 1.5),),
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
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: closingDateController,
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
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: address1Controller,
                        inputType: TextInputType.number,
                        onChanged: (value) {
                        },
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
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: address1Controller,
                        inputType: TextInputType.number,
                        onChanged: (value) {
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.blue
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                          child: FLText(
                            displayText: "Add",
                            textColor: Colors.white,
                            setToWidth: false,
                            textSize: AppFonts.textFieldFontSize14,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                                  EventRegistrationStep3(
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
      closingDateController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
    });
  }
}
