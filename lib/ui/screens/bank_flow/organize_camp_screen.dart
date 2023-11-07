import 'package:bood_donate/controllers/bank_home_controller.dart';
import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/ui/reusable/main_button.dart';
import 'package:bood_donate/ui/reusable/text_input_field.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrganizeCampScreen extends StatelessWidget {
  const OrganizeCampScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Consumer<BankHomeController>(
          builder: (context, controller, child) => Column(
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
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      left: 16.w, right: 16.w, top: 22.h, bottom: 8.h),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.w),
                    color: AppColors.foregroundColor,
                  ),
                  child: Center(
                      child: Text(
                    'Organize a Camp',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.w),
                  ))),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 8.w,
                                  right: 16.w,
                                  top: 8.h,
                                  bottom: 16.h),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.w),
                                color: AppColors.foregroundColor,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                      '${controller.bank?.campCount ?? 'n/a'}',
                                      style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: 48.w,
                                          fontWeight: FontWeight.w600)),
                                  Text('Total Camps Conducted',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.w,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      16.verticalSpace,
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: Column(
                          children: [
                            TextInputField(
                              hint: 'Camp Name',
                              height: 60.h,
                              textController: controller.nameController,
                            ),
                            16.verticalSpace,
                            GestureDetector(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015, 8),
                                    lastDate: DateTime(2101));
                                if (picked != null &&
                                    picked != DateTime.now()) {
                                  controller.onSelectDate(picked);
                                }
                              },
                              child: TextInputField(
                                hint: 'Date',
                                height: 60.h,
                                enabled: false,
                                textController: controller.dateController,
                              ),
                            ),
                            16.verticalSpace,
                            TextInputField(
                              hint: 'Location',
                              height: 60.h,
                              textController: controller.locController,
                            ),
                            16.verticalSpace,
                            TextInputField(
                              hint: 'Contact No.',
                              height: 60.h,
                              textController: controller.numController,
                            ),
                            16.verticalSpace,
                            controller.organizing ? LoaderWidget() : MainButton(text: 'ADD', onPressed: () {controller.organizeCamp(context);}),
                            16.verticalSpace,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
