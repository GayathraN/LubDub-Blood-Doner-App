import 'package:bood_donate/controllers/bank_home_controller.dart';
import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/ui/reusable/main_button.dart';
import 'package:bood_donate/ui/screens/common/sign_in_screen.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BankProfileScreen extends StatelessWidget {
  const BankProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 16.w),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                  20.horizontalSpace,
                  Image.asset(
                    'assets/images/header_logo.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    16.verticalSpace,
                    Icon(
                      Icons.account_balance,
                      size: 90.w,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, left: 16.w),
                      child: Text(
                          context.watch<BankHomeController>().bank?.name ??
                              'n/a',
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 18.w,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 16.h,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: AppColors.foregroundColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.numbers,
                              size: 28.w,
                              color: Colors.grey,
                            ),
                            20.horizontalSpace,
                            Text(
                              context
                                      .watch<BankHomeController>()
                                      .bank
                                      ?.bankId ??
                                  'n/a',
                              style: TextStyle(
                                  fontSize: 15.w, color: Colors.white),
                            )
                          ],
                        )),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 16.h,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: AppColors.foregroundColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pin_drop,
                              size: 28.w,
                              color: Colors.grey,
                            ),
                            20.horizontalSpace,
                            Text(
                              context
                                      .watch<BankHomeController>()
                                      .bank
                                      ?.location ??
                                  'n/a',
                              style: TextStyle(
                                  fontSize: 15.w, color: Colors.white),
                            )
                          ],
                        )),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 16.h,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: AppColors.foregroundColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone,
                              size: 28.w,
                              color: Colors.grey,
                            ),
                            20.horizontalSpace,
                            Text(
                              context
                                      .watch<BankHomeController>()
                                      .bank
                                      ?.contact ??
                                  'n/a',
                              style: TextStyle(
                                  fontSize: 15.w, color: Colors.white),
                            )
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: MainButton(
                        text: 'Logout',
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .signOut()
                              .whenComplete(() => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          (const SignInScreen(disableBack: true,)),
                                    ),
                                  ));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
