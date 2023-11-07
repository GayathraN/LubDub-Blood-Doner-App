import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/ui/reusable/main_button.dart';
import 'package:bood_donate/ui/screens/common/sign_in_screen.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DonorProfileScreen extends StatelessWidget {
  const DonorProfileScreen({super.key});

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
                    onPressed: () {Navigator.pop(context);},
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
              child: Consumer<DonorHomeController>(
                builder: (context, controller, child) =>SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      16.verticalSpace,
                      Icon(
                        Icons.account_circle,
                        size: 90.w,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.h, left: 16.w),
                        child: Text(controller.donor?.name ?? 'n/a',
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
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.cake,size: 28.w,color: Colors.grey,),
                          20.horizontalSpace,
                          Text('${(controller.donor?.dob == null || controller.donor?.dob == '') ? 'n/a' :
                          DateFormat('dd MMM yyyy').format(DateTime.parse(controller.donor!.dob!)) }',style: TextStyle(fontSize: 15.w,color: Colors.white),)
                        ],
                      ) ),
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
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.pin_drop,size: 28.w,color: Colors.grey,),
                              20.horizontalSpace,
                              Text(controller.donor?.address ?? 'n/a',style: TextStyle(fontSize: 15.w,color: Colors.white),)
                            ],
                          ) ),
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
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.phone,size: 28.w,color: Colors.grey,),
                              20.horizontalSpace,
                              Text(controller.donor?.contact ?? 'n/a',style: TextStyle(fontSize: 15.w,color: Colors.white),)
                            ],
                          ) ),
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
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.perm_identity,size: 28.w,color: Colors.grey,),
                              20.horizontalSpace,
                              Text(controller.donor?.nic ?? 'n/a',style: TextStyle(fontSize: 15.w,color: Colors.white),)
                            ],
                          ) ),
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
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.male,size: 28.w,color: Colors.grey,),
                              20.horizontalSpace,
                              Text(controller.donor?.gender ?? 'n/a',style: TextStyle(fontSize: 15.w,color: Colors.white),)
                            ],
                          ) ),
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: MainButton(text: 'Logout',onPressed: () async {
                          await FirebaseAuth.instance.signOut().whenComplete(() => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (const SignInScreen(disableBack: true,)),
                              ),
                            )
                          );
                        },),
                      )
                    ],
                  ),
                ),
              ),),
            ),

          ],
        ),
      ),
    );
  }
}
