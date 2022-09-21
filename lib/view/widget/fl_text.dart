import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:flutter/material.dart';

/// Text view text to fill the entire width, using any font size or it occupies the minimum width with the specified font size.
/// set setToWidth = false and give textSize to occupies the minimum width with the specified font size

class FLText extends StatelessWidget {
  final String displayText;
  final Color textColor;
  final bool setToWidth;
  final double textSize;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const FLText({
    this.displayText,
    this.textColor = AppColors.kTextDark,
    this.setToWidth = true,
    this.textSize = 16,
    this.textAlign = TextAlign.left,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: setToWidth ? BoxFit.contain : BoxFit.none,
      child: Text(
        displayText,
        maxLines: 2,
        textAlign: textAlign,
        style: setToWidth
            ? TextStyle(
                fontWeight: fontWeight,
                color: textColor,
                fontFamily: AppFonts.circularStd,
              )
            : TextStyle(
                fontWeight: fontWeight,
                color: textColor,
                fontFamily: AppFonts.circularStd,
                fontSize: textSize),
      ),
    );
  }
}
