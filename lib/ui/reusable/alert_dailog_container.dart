import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertDialogContainer extends StatelessWidget {
  final String title;
  final Widget contentWidget;
  final bool showCloseBtn;
  final VoidCallback? onClosePress;
  final Alignment alignment;

  const AlertDialogContainer(
      {super.key, required this.title, required this.contentWidget, this.showCloseBtn = true, this.onClosePress, this.alignment = Alignment.center});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        alignment: alignment,
        elevation: 0,
        backgroundColor: AppColors.foregroundColor,
        surfaceTintColor: AppColors.foregroundColor,
        insetPadding: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.foregroundColor,
              borderRadius: BorderRadius.circular(18.r)),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              8.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 43.w,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text(
                        title,
                        style: TextStyle(color: Colors.white, fontSize: 17.5.w, fontWeight: FontWeight.w600),
                      ),
                    ),
                    showCloseBtn ? IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                          onClosePress??();
                          },
                        color:Colors.white,
                        icon: Icon(Icons.close,color:
                            Colors.white,)
                    ) : SizedBox(
                      width: 43.w,
                    ),
                  ],
                ),
              ),
              contentWidget
            ],
          ),
        ));
  }
}

// how to use
// showDialog(
// context: context,
// barrierDismissible: true,
// builder: (_) => AlertDialogContainer(
// title: 'Add Category',
// contentWidget: Container(),
// ));
// }),