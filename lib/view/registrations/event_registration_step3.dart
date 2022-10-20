
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:eventz/view/widget/imput_square_text_field.dart';
import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../../configs/fonts.dart';
import '../../configs/images.dart';
import '../widget/fl_text.dart';

class EventRegistrationStep3 extends StatefulWidget {
  static var routeName = "/event_registration_step3";

  const EventRegistrationStep3({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventRegistrationStep3State();
}

class _EventRegistrationStep3State extends State<EventRegistrationStep3> {

  DateTime pickedDate = DateTime.now();
  final TextEditingController priceCategoryController = new TextEditingController();
  final TextEditingController eventPriceCategory = new TextEditingController();
  final TextEditingController termAndConditionsController = new TextEditingController();
  final TextEditingController quantityController = new TextEditingController();
  final TextEditingController percentageController = new TextEditingController();
  final TextEditingController EBEndDateController = new TextEditingController();
  final TextEditingController EBStartDateController = new TextEditingController();
  FocusNode _passwordFocusNode;
  FocusNode _confirmPasswordFocusNode;
  Country _selectedCountry;

  String _dropDownValue;
  bool isCheckedBankTransfer =  false;
  bool isCheckedCashOnTheEventDay =  false;
  bool isCheckedCheque =  false;
  bool isCheckedOnlinePayment =  false;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
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
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          width: 1000,
          decoration: const BoxDecoration(
              color: AppColors.kWhite
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 75),
            child: Column(
              children: [
                Row(
                  children: [
                    FLText(
                      displayText: "Price Information",
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
                    FLText(
                      displayText: "Price Category",
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
                        textController: priceCategoryController,
                        inputType: TextInputType.number,
                        onChanged: (value) {
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    FLText(
                      displayText: "Event Price",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 58,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: eventPriceCategory,
                        inputType: TextInputType.number,
                        onChanged: (value) {
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    FLText(
                      displayText: "Quantity",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 73,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: quantityController,
                        inputType: TextInputType.number,
                        onChanged: (value) {
                        },
                      ),
                    ),

                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5,right: 8),
                      child: Container(
                        height: 45,
                        width: 60,
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
                            fontWeight: FontWeight.w600,
                            textSize: AppFonts.textFieldFontSize14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),


                Row(
                  children: [
                    FLText(
                      displayText: "EB Start Date :",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 36,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: EBStartDateController,
                        inputType: TextInputType.number,
                        onSuffixPress: (){
                          dateSelection(true);
                        },
                        suffixIcon: Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    FLText(
                      displayText: "EB End Date :",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 44,
                    ),
                    Expanded(
                      child: InputSquareTextField(
                        padding:const EdgeInsets.symmetric(vertical: 5),
                        readOnly: false,
                        textController: EBEndDateController,
                        inputType: TextInputType.number,
                        onSuffixPress: (){
                          dateSelection(false);
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
                      displayText: "Percentage %",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                    SizedBox(
                      width: 36,
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 120),
                          child: InputSquareTextField(
                          padding:const EdgeInsets.symmetric(vertical: 5),
                          readOnly: false,
                          textController: percentageController,
                          inputType: TextInputType.number,
                          onChanged: (value) {
                          },
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
                    FLText(
                      displayText: "Payment Information",
                      textColor: AppColors.kTextDark,
                      setToWidth: false,
                      textSize: AppFonts.textFieldFontSize14,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                // fillColor: Colors.purple,
                                value: isCheckedBankTransfer,
                                onChanged: (bool value) {
                                  setState(() {
                                    isCheckedBankTransfer = value;
                                    isCheckedCashOnTheEventDay = false;
                                    isCheckedCheque = false;
                                    isCheckedOnlinePayment = false;
                                  });
                                },
                              ),
                              FLText(
                                displayText: "Bank Transfer",
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
                                  value: isCheckedCashOnTheEventDay,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isCheckedCashOnTheEventDay = value;
                                      isCheckedBankTransfer = false;
                                      isCheckedCheque = false;
                                      isCheckedOnlinePayment = false;
                                    });
                                  },
                                ),
                                FLText(
                                  displayText: "Cash on the Event Day",
                                  textColor: AppColors.kTextDark,
                                  setToWidth: false,
                                  textSize: AppFonts.textFieldFontSize14,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 56),
                            child: Row(
                              children: [

                                Checkbox(
                                  checkColor: Colors.white,
                                  // fillColor: Colors.purple,
                                  value: isCheckedCheque,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isCheckedCheque = value;
                                      isCheckedBankTransfer = false;
                                      isCheckedCashOnTheEventDay = false;
                                      isCheckedOnlinePayment = false;
                                    });
                                  },
                                ),
                                FLText(
                                  displayText: "Cheque",
                                  textColor: AppColors.kTextDark,
                                  setToWidth: false,
                                  textSize: AppFonts.textFieldFontSize14,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 84),
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  // fillColor: Colors.purple,
                                  value: isCheckedOnlinePayment,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isCheckedOnlinePayment = value;
                                      isCheckedBankTransfer = false;
                                      isCheckedCashOnTheEventDay = false;
                                      isCheckedCheque = false;
                                    });
                                  },
                                ),
                                FLText(
                                  displayText: "Online Payment",
                                  textColor: AppColors.kTextDark,
                                  setToWidth: false,
                                  textSize: AppFonts.textFieldFontSize14,
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
                  height: 8,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FLText(
                          displayText: "Term & Conditions :",
                          textColor: AppColors.kTextDark,
                          setToWidth: false,
                          textSize: AppFonts.textFieldFontSize14,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
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
                  ],
                ),

                SizedBox(
                  height: 8,
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
                              displayText: "Finish",
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


  Future<void> dateSelection(bool isStartDate) async {
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
      if(isStartDate == false) {
        EBEndDateController.text =
        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }
      else if(isStartDate == true){
        EBStartDateController.text =
        "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      }
    });
  }
}
