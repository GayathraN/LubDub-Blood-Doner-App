import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TextButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  /// should pass an icon if icon null show only text
  final IconData? iconData;

  /// if icon provided please provide a color
  final Color? color;
  final double iconSize;
  final double fontSize;

  const TextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.iconData,
    this.iconSize = 24.0,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return iconData != null
        ? TextButton.icon(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.symmetric(vertical: 2.w,horizontal: 4.w),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: Icon(
              iconData,
              color: color,
              size: iconSize.w,
            ),
            label: Text(
              text,
            ),
          )
        : TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.symmetric(vertical: 2.w,horizontal: 8.w),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(color: color ?? Colors.white,fontSize: 14.w),
            ),
          );
  }
}
