import 'package:eventz/view/widget/custom_dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  // static const platform = const MethodChannel('com.flash.dev/ecnrypt');

  // SharedPref sharedPref = SharedPref();
  // SecureStorage _secStorage = SecureStorage();
  static Helper _instance;
  BuildContext context;

  factory Helper() => _instance ??= new Helper._();

  Helper._();

  showAlertView(BuildContext context, String message, Function callBack,
      String positiveText,
      {String title}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: title,
            descriptions: message,
            textPositive: positiveText,
            callback: callBack,
          );
        });
  }

  List _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  ///get month short name
  String getMonthShortName(int pos) {
    return _months[pos - 1];
  }

  String getDate(String dateValue) {
    String apiDate = dateValue.split(" ")[0];
    String year = "";
    String date = "";
    String month = "";
    try {
      year = apiDate.split("/")[2];
      date = apiDate.split("/")[1];
      month = apiDate.split("/")[0];
      if (date.length == 1) {
        date = "0" + date;
      }
      if (month.length == 1) {
        month = "0" + month;
      }
      return date + "." + month + "." + year;
      // }
    } catch (e) {
      return "--";
    }
  }

  String getTime(String dateValue) {
    String apiDate = dateValue.split(" ")[1];
    try {
      return apiDate;
    } catch (e) {
      return "--";
    }
  }
}

// enum AccountTypes {
//   primary,
//   general_savings,
//   cb_other,
//   other_bank,
//   saving_goal
// }
