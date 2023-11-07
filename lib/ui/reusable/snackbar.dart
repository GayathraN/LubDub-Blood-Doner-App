import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showToast(BuildContext context, String message, {bool isSuccess = false}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: isSuccess ? Colors.black : Colors.black, // Change text color
        fontSize: 14.w, // Change font size
        fontWeight: FontWeight.bold, // Change font weight
      ),
    ),
    backgroundColor: isSuccess ? AppColors.successColor : AppColors.textColor, // Change background color
    duration: Duration(seconds: 4), // Change duration
    behavior: SnackBarBehavior.floating, // Change behavior
    shape: RoundedRectangleBorder( // Change shape
      borderRadius: BorderRadius.circular(8),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}