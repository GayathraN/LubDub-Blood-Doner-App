import 'dart:math';

import 'package:bood_donate/controllers/bank_signup_controller.dart';
import 'package:bood_donate/controllers/donor_signup_controller.dart';
import 'package:bood_donate/ui/reusable/dropdown_field.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/ui/reusable/main_button.dart';
import 'package:bood_donate/ui/reusable/text_button.dart';
import 'package:bood_donate/ui/reusable/text_input_field.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BankSignUpScreen extends StatelessWidget {

  BankSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Consumer<BankSignUpController>(
        builder: (context, controller, child) => Column(
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Register as Blood Bank',style: TextStyle(color: Colors.white,fontSize: 16.w,fontWeight: FontWeight.w600),),
                      60.verticalSpace,
                      TextInputField(
                        hint: 'Blood Bank Name',
                        height: 60.h,
                        textController: controller.nameController,
                      ),
                      16.verticalSpace,
                      TextInputField(
                        hint: 'Blood Bank ID',
                        height: 60.h,
                        textController: controller.idController,
                      ),
                      16.verticalSpace,
                      TextInputField(
                        hint: 'Location',
                        height: 60.h,
                        textController: controller.locationController,
                      ),
                      16.verticalSpace,
                      TextInputField(
                        hint: 'Contact No',
                        height: 60.h,
                        textController: controller.contactController,
                      ),
                      16.verticalSpace,
                      TextInputField(
                        hint: 'Email',
                        height: 60.h,
                        textController: controller.emailController,
                      ),
                      16.verticalSpace,
                      TextInputField(
                        hint: 'Password',
                        isPwd: true,
                        height: 60.h,
                        textController: controller.pwdController,
                      ),
                      16.verticalSpace,
                      controller.isLoading ? LoaderWidget() : MainButton(text: 'Register',onPressed: (){controller.registerUser(context);}),
                      16.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),),
      ),
    );
  }
}

