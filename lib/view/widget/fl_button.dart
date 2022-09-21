import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:flutter/material.dart';

class FLButton extends StatelessWidget {
  final String title;
  final int fontSize;
  final Function onPressed;
  final bool isEnabled;
  final bool isSelected;
  final Color backgroundColor;
  final Color borderColor;
  final double minWidth;
  final double height;
  final double borderRadius;
  final double titleFontSize;
  final Color titleFontColor;
  final Color hightLightColor;
  final Alignment buttonTextAlignment;
  final String surfixImage;

  const FLButton(
      {this.title,
      this.fontSize,
      this.onPressed,
      this.isEnabled = true,
      this.isSelected = true,
      this.backgroundColor = Colors.transparent,
      this.minWidth = 100,
      this.height = 40,
      this.borderRadius = 6,
      this.titleFontSize = 16,
      this.titleFontColor = AppColors.kSecondary,
      this.hightLightColor = AppColors.buttonClick,
      this.borderColor = Colors.amber,
      this.buttonTextAlignment = Alignment.center,
      this.surfixImage = ""});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: minWidth,
      height: height,
      splashColor: Colors.transparent,
      highlightColor: hightLightColor,
      color: backgroundColor,
      textColor: isSelected ? AppColors.kSecondary : Colors.white,
      padding: const EdgeInsets.all(8),
      onPressed: isEnabled ? onPressed : null,
      child: Align(
        alignment: buttonTextAlignment,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          surfixImage != ""
              ? Image.asset(
                  surfixImage,
                  width: 30,
                  height: 20,
                )
              : SizedBox.shrink(),
          Text(
            title,
            style: TextStyle(
              fontFamily: AppFonts.circularStd,
              fontSize: titleFontSize,
              color: titleFontColor,
            ),
          ),
        ]),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
              color: borderColor, width: 1, style: BorderStyle.solid)),
    );
  }
}
