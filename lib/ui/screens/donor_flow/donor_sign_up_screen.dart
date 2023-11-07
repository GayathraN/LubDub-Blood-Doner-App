import 'dart:math';

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

class DonorSignUpScreen extends StatelessWidget {

  DonorSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Consumer<DonorSignUpController>(
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
                      Text('Register as Donor',style: TextStyle(color: Colors.white,fontSize: 16.w,fontWeight: FontWeight.w600),),
                      16.verticalSpace,
                      TextInputField(
                        hint: 'Name',
                        height: 60.h,
                        textController: controller.nameController,
                      ),
                      16.verticalSpace,
                      TextInputField(
                        hint: 'Email Address',
                        height: 60.h,
                        textController: controller.emailController,
                      ),
                      16.verticalSpace,
                      TextInputField(
                        hint: 'Home Address',
                        height: 60.h,
                        textController: controller.addressController,
                      ),
                      16.verticalSpace,
                      TextInputField(
                        hint: 'Password',
                        isPwd: true,
                        height: 60.h,
                        textController: controller.pwdController,
                      ),
                      16.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: TextInputField(
                              hint: 'NIC No',
                              height: 60.h,
                              textController: controller.nicController,
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime(2101));
                                if (picked != null && picked != DateTime.now()) {
                                 controller.onSelectDob(picked);
                                }
                              },
                              child: TextInputField(
                                hint: 'DOB',
                                enabled: false,
                                height: 60.h,
                                textController: controller.dobController,
                              ),
                            ),
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: TextInputField(
                              hint: 'Contact No',
                              height: 60.h,
                              textController: controller.contactController,
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: DropdownField<String>(
                              hint: 'Gender',
                              onChanged: (value){
                                controller.onSelectGender(value);
                              },
                              items: ['Male', 'Female','Other'],
                              height: 60.h,
                            )
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: AppColors.foregroundColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('A+',style: TextStyle(color: Colors.white),),
                                    leading: Radio<BloodGroup>(
                                      activeColor: AppColors.accentColor,
                                      value: BloodGroup.aPlus,
                                      groupValue: controller.character,
                                      onChanged: (BloodGroup? value) {
                                        controller.onSelectBloodGroup(value);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('A-',style: TextStyle(color: Colors.white),),
                                    leading: Radio<BloodGroup>(
                                      activeColor: AppColors.accentColor,
                                      value: BloodGroup.aMin,
                                      groupValue: controller.character,
                                      onChanged: (BloodGroup? value) {
                                        controller.onSelectBloodGroup(value);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('B+',style: TextStyle(color: Colors.white),),
                                    leading: Radio<BloodGroup>(
                                      activeColor: AppColors.accentColor,
                                      value: BloodGroup.bPlus,
                                      groupValue: controller.character,
                                      onChanged: (BloodGroup? value) {
                                        controller.onSelectBloodGroup(value);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('B-',style: TextStyle(color: Colors.white),),
                                    leading: Radio<BloodGroup>(
                                      activeColor: AppColors.accentColor,
                                      value: BloodGroup.bMin,
                                      groupValue: controller.character,
                                      onChanged: (BloodGroup? value) {
                                        controller.onSelectBloodGroup(value);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('AB',style: TextStyle(color: Colors.white),),
                                    leading: Radio<BloodGroup>(
                                      activeColor: AppColors.accentColor,
                                      value: BloodGroup.ab,
                                      groupValue: controller.character,
                                      onChanged: (BloodGroup? value) {
                                        controller.onSelectBloodGroup(value);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('O+',style: TextStyle(color: Colors.white),),
                                    leading: Radio<BloodGroup>(
                                      activeColor: AppColors.accentColor,
                                      value: BloodGroup.oPlus,
                                      groupValue: controller.character,
                                      onChanged: (BloodGroup? value) {
                                        controller.onSelectBloodGroup(value);
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text('O-',style: TextStyle(color: Colors.white),),
                                    leading: Radio<BloodGroup>(
                                      activeColor: AppColors.accentColor,
                                      value: BloodGroup.oMin,
                                      groupValue: controller.character,
                                      onChanged: (BloodGroup? value) {
                                        controller.onSelectBloodGroup(value);
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80.w,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      16.verticalSpace,
                      controller.isLoading ? const LoaderWidget() : MainButton(text: 'Register',onPressed: (){controller.registerUser(context);}),
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

