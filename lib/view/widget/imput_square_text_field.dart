import 'package:eventz/configs/colors.dart';
import 'package:eventz/configs/fonts.dart';
import 'package:flutter/material.dart';

/// Text view text to fill the entire width, using any font size or it occupies the minimum width with the specified font size.
/// set setToWidth = false and give textSize to occupies the minimum width with the specified font size

class InputSquareTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final ValueChanged onChanged;
  final bool autoFocus;
  final TextInputAction inputAction;
  final bool isValid;
  final bool readOnly;
  final Icon suffixIcon;
  final double hight;
  final int lines;
  final double width;
  final String prefixIcon;
  final VoidCallback onSuffixPress;
  final VoidCallback onPrefixPress;
  final VoidCallback onTapping;
  final Color textColor;
  final String Function(String v) validator;
  final bool autoValidate;

  const InputSquareTextField(
      {Key key,
        this.icon,
        this.hint,
        this.prefixIcon,
        this.errorText,
        this.onTapping,
        this.isObscure = false,
        this.inputType,
        this.textController,
        this.isIcon = true,
        this.padding = const EdgeInsets.all(0),
        this.hintColor = AppColors.TextGray,
        this.iconColor = AppColors.TextGray,
        this.focusNode,
        this.onFieldSubmitted,
        this.onChanged,
        this.autoFocus = false,
        this.inputAction,
        this.isValid = false,
        this.suffixIcon,
        this.onSuffixPress,
        this.textColor,
        this.autoValidate = false,
        this.validator, TextEditingController controller, InputDecoration decoration, this.readOnly, this.onPrefixPress, this.hight, this.width, this.lines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Container(
          height: hight ?? 40,
          width: width,
          child: TextFormField(
              readOnly: readOnly,
              controller: textController,
              focusNode: focusNode,
              onFieldSubmitted: onFieldSubmitted,
              onChanged: onChanged,
              autofocus: autoFocus,
              textInputAction: inputAction,
              obscureText: isObscure,
              keyboardType: inputType,
              validator: validator,
              onTap: onTapping,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(color: textColor,fontSize: 13),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: hint,
                  hintStyle: TextStyle(
                      fontSize: 13.0,
                      color: hintColor.withOpacity(0.3),
                    fontWeight: FontWeight.bold
                  ),
                  errorText: errorText,
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.TextGray.withOpacity(0.5), width: 1.5),),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.TextGray.withOpacity(0.5), width: 1.5),),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.TextGray.withOpacity(0.5), width: 1.5),),
                  prefixIcon: prefixIcon != null
                  // ? isValid != null && isValid
                      ? IconButton(
                      icon: Image.asset(
                        prefixIcon,
                        color: Colors.red,
                        width: 35,
                        height: 35,
                      ),
                      onPressed: onPrefixPress)
                      : null,
                  suffixIcon: suffixIcon != null
                  // ? isValid != null && isValid
                      ? IconButton(
                      icon: suffixIcon,
                      onPressed: onSuffixPress)
                      : null
              )),
        )
    );
  }
}