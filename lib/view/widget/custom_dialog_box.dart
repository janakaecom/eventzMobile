import 'dart:ui';

import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:eventz/utils/constants.dart';

///Ayesh Don
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, textPositive, textNegative;
  final Image img;
  final VoidCallback callback;
  final Function(String) callbackWithReturn;
  final bool showPicker;
  final List pickerArr;
  final bool isWithoutPop;

  const CustomDialogBox(
      {Key key,
      this.title,
      this.descriptions,
      this.textPositive,
      this.textNegative,
      this.img,
      this.showPicker = false,
      this.pickerArr,
      this.callbackWithReturn,
      this.callback,
      this.isWithoutPop = false})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.alertPadding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  showMobileNumbers(pickerArr) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(fontSize: AppFonts.alertMenuFontSize),
        ),
        SizedBox(
          height: 15,
        ),
        for (var pickerValue in pickerArr)
          Container(
              child: Column(
            children: [
                  TextButton(),
              // FlatButton(
              //   padding: const EdgeInsets.all(8),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //     widget.callbackWithReturn(pickerValue);
              //   },
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       pickerValue.toString(),
              //       style: TextStyle(
              //         fontFamily: AppFonts.circularStd,
              //         fontSize: AppFonts.drawerMenuFontSize,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                height: 0.5,
                color: AppColors.kTextLight,
              ),
            ],
          )),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: AppConstants.alertPadding,
              top: AppConstants.alertAvatarRadius,
              right: AppConstants.alertPadding,
              bottom: 10),
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 1), blurRadius: 1),
              ]),
          child: widget.showPicker == true
              ? showMobileNumbers(widget.pickerArr)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    (widget.title != null)
                        ? Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: AppFonts.alertHeaderFontSize),
                          )
                        : Container(),
                    SizedBox(
                      height: (widget.title != null) ? 15 : 0,
                    ),
                    Text(
                      widget.descriptions,
                      style: TextStyle(fontSize: AppFonts.alertBodyFontSize),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            Spacer(),
                            (widget.textNegative != null)
                                ? negativeButton()
                                : Container(),
                            SizedBox(
                              width: 15,
                            ),
                            positiveButton(),
                          ],
                        )),
                  ],
                ),
        ),
        Positioned(
          left: AppConstants.alertPadding,
          right: AppConstants.alertPadding,
          top: 0,
          child: circleAvatar(),
        ),
      ],
    );
  }

  /// circle avatar
  Widget circleAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 45,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.asset("assets/images/img_alert_header.png",
              width: 60.0)), //assets/ic_alert_header.png
    );
  }

  /// negative button design for alert
  Widget positiveButton() {
    return
      GestureDetector(
          onTap: (){
            onAlertClick();
          },
          child: Container(
            // height: height,
            // width: minWidth,
            alignment: Alignment.center,
            // margin: margin,
            decoration: BoxDecoration(
                color: AppColors.kSecondary,
                borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
               color: AppColors.kSecondary
              )
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.textPositive,
                style: TextStyle(fontSize: AppFonts.buttonFontSize,color: Colors.white),
              )
            ),
          ));
      // FlatButton(
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(5.0),
      //       side: BorderSide(color: AppColors.kSecondary)),
      //   onPressed: () {
      //     onAlertClick();
      //   },
      //   color: AppColors.kSecondary,
      //   textColor: Colors.white,
      //   child: Text(
      //     widget.textPositive,
      //     style: TextStyle(fontSize: AppFonts.buttonFontSize),
      //   ));
  }

  /// positive button design for alert
  Widget negativeButton() {
    return  GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
          // height: height,
          // width: minWidth,
          alignment: Alignment.center,
          // margin: margin,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.textPositive,
                style: TextStyle(fontSize: AppFonts.buttonFontSize,color: AppColors.kSecondary),
              )
          ),
        ));
      // FlatButton(
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10.0),
      //       side: BorderSide(color: Colors.transparent)),
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      //   color: Colors.transparent,
      //   textColor: AppColors.kSecondary,
      //   child: Text(
      //     widget.textNegative,
      //     style: TextStyle(fontSize: AppFonts.buttonFontSize),
      //   ));
  }

  ///on alert close click
  void onAlertClick() {
    widget.callback();
    if (!widget.isWithoutPop) {
      Navigator.of(context).pop();
    }
  }
}
