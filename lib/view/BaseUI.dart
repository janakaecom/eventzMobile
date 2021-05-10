import 'package:eventz/api/api_service.dart';
import 'package:eventz/configs/colors.dart';
import 'package:eventz/utils/helper.dart';
import 'package:eventz/utils/shared_storage.dart';
import 'package:eventz/view/widget/fl_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

mixin BaseUI {
  Helper helper = Helper();
  APIService apiService = APIService();
  SharedPref sharedPref = SharedPref();
  String langCode = Get.locale.languageCode;
  NumberFormat oCcy = new NumberFormat("#,##0.00", "en_UK");
  String emptyString = " ";

  ///
  /// Hide Progress bar
  ///
  void hideProgressbar(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  ///
  /// Show progress bar
  ///
  void showProgressbar(BuildContext context, {String text}) {
    helper.context = context;
    Future.delayed(Duration.zero, () {
      final _screenSize = MediaQuery.of(context).size;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: new BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: const Radius.circular(10.0),
                  )),
              width: _screenSize.width * 0.1,
              margin: const EdgeInsets.only(left: 80.0, right: 80.0),
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  FLText(
                    displayText: text != null ? text : 'loading'.tr,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
