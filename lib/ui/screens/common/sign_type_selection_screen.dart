import 'package:bood_donate/controllers/sign_in_controller.dart';
import 'package:bood_donate/ui/reusable/main_button.dart';
import 'package:bood_donate/ui/reusable/text_button.dart';
import 'package:bood_donate/ui/reusable/text_input_field.dart';
import 'package:bood_donate/ui/screens/bank_flow/bank_sign_up_screen.dart';
import 'package:bood_donate/ui/screens/donor_flow/donor_sign_up_screen.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignUpTypeScreen extends StatelessWidget {
  const SignUpTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Register as a',style: TextStyle(color: Colors.white,fontSize: 16.w,fontWeight: FontWeight.w600),),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> DonorSignUpScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 16.w,
                              right: 8.w,
                              top: 16.h,
                              bottom: 16.h),
                          padding: EdgeInsets.symmetric(vertical: 16.w,horizontal: 32.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w),
                            color: AppColors.foregroundColor,
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.account_circle,color: Colors.white,size: 80.w,),
                              Text('Donor',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.w,
                                      fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> BankSignUpScreen()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 16.w,
                              right: 8.w,
                              top: 16.h,
                              bottom: 16.h),
                          padding: EdgeInsets.symmetric(vertical: 16.w,horizontal: 32.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w),
                            color: AppColors.foregroundColor,
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.account_balance,color: Colors.white,size: 80.w,),
                              Text('Blood Bank',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.w,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox()
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
