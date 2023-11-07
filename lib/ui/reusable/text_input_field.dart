import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputField extends StatelessWidget {
  final String hint;
  final TextEditingController textController;
  final Widget? suffixIcon;
  final String? suffixText;
  final double height;
  final TextInputType inputType;
  final ValueChanged<String?>? onChanged;
  final bool enabled;
  final double rightPadding;
  final int? maxLength;
  final bool isGrayOut;
  final bool isPwd;

  const TextInputField(
      {Key? key,
      required this.hint,
      required this.textController,
      this.suffixIcon,
      this.suffixText,
      this.height = 55.0,
      this.inputType = TextInputType.text, this.onChanged, this.enabled = true, this.rightPadding = 15, this.maxLength, this.isGrayOut = false, this.isPwd = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.w, top: 1.h, bottom: 1.h, right: rightPadding.w),
      height: height.h,
      decoration: BoxDecoration(
          color: AppColors.foregroundColor,
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Center(
        child: TextFormField(
          obscureText: isPwd,
          controller: textController,
          onChanged: onChanged,
          enabled: enabled,
          maxLength: maxLength,
          keyboardType: inputType,
          textAlignVertical: suffixIcon != null ? TextAlignVertical.center : null,
          textCapitalization: TextCapitalization.sentences,
          cursorColor: AppColors.accentColor,
          style: TextStyle(fontSize: 15.w,color: Colors.white),
          decoration: InputDecoration(
            counterText: '',
            suffixText: suffixText,
            suffixIcon: suffixIcon,
            suffixStyle: TextStyle(color: Colors.grey,fontSize: 15.w),
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey,fontSize: 15.w),
          ),
        ),
      ),
    );
  }
}
