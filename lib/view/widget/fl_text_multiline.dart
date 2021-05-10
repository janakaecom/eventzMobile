import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:flutter/material.dart';

class FLTextMultiLine extends StatelessWidget {
  final String displayText;
  final Color textColor;
  final double textSize;
  final int maxLine;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const FLTextMultiLine({
    this.displayText,
    this.textColor = AppColors.kTextDark,
    this.textSize = 16,
    this.maxLine = 1,
    this.textAlign = TextAlign.left,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        displayText,
        maxLines: maxLine,
        textAlign: textAlign,
        style: TextStyle(
            fontWeight: fontWeight,
            color: textColor,
            fontFamily: AppFonts.circularStd,
            fontSize: textSize),
      ),
    );
  }
}
