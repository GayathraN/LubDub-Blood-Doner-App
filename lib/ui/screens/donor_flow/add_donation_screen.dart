import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/model/bank.dart';
import 'package:bood_donate/model/camp_history.dart';
import 'package:bood_donate/ui/reusable/dropdown_field.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/ui/reusable/main_button.dart';
import 'package:bood_donate/ui/reusable/text_input_field.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddDonationScreen extends StatefulWidget {
  const AddDonationScreen({super.key});

  @override
  State<AddDonationScreen> createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends State<AddDonationScreen> {

  @override
  void initState() {
    final homeController = Provider.of<DonorHomeController>(context, listen: false);
    homeController.mainReset();
    homeController.getBloodBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Consumer<DonorHomeController>(
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
                    'Record a Donation',
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
                                  left: 16.w,
                                  right: 8.w,
                                  top: 8.h,
                                  bottom: 16.h),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.w),
                                color: AppColors.foregroundColor,
                              ),
                              child: Column(
                                children: [
                                  Text(controller.donor?.bloodGroup ?? 'n/a',
                                      style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: 48.w,
                                          fontWeight: FontWeight.w600)),
                                  Text('Blood Group',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.w,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
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
                                      '${controller.donor?.donateCount ?? 'n/a'}',
                                      style: TextStyle(
                                          color: AppColors.accentColor,
                                          fontSize: 48.w,
                                          fontWeight: FontWeight.w600)),
                                  Text('Donation Count',
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
                      controller.isBloodBanksLoading ? LoaderWidget() : Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: DropdownField<Bank>(
                                      hint: 'Select Blood Bank',
                                      onChanged: (value){
                                         controller.onBankSelect(value);
                                      },
                                      items: controller.bankList,
                                      itemBuilder: (bank) => Text('${bank.name}',style:TextStyle(fontSize: 15.w,color: Colors.white)),
                                      height: 60.h,
                                    )
                                ),
                              ],
                            ),
                            16.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                    child: DropdownField<CampHistory>(
                                      hint: 'Select Blood Camp',
                                      onChanged: (value){
                                        if(value != null) {
                                          controller.onSelectCamp(value);
                                        }
                                      },
                                      items: controller.selectedCampList,
                                      itemBuilder: (bank) => Text('${bank.campName}',style:TextStyle(fontSize: 15.w,color: Colors.white)),
                                      height: 60.h,
                                    )
                                ),
                              ],
                            ),
                            16.verticalSpace,
                            GestureDetector(
                              onTap: () async {
                                // final DateTime? picked = await showDatePicker(
                                //     context: context,
                                //     initialDate: DateTime.now(),
                                //     firstDate: DateTime(2015, 8),
                                //     lastDate: DateTime(2101));
                                // if (picked != null &&
                                //     picked != DateTime.now()) {
                                //   controller.onSelectDate(picked);
                                // }
                              },
                              child: TextInputField(
                                hint: 'Donation Date',
                                height: 60.h,
                                enabled: false,
                                textController: controller.dateController,
                              ),
                            ),
                            16.verticalSpace,
                            TextInputField(
                              hint: 'Location',
                              enabled: false,
                              height: 60.h,
                              textController: controller.locController,
                            ),
                            // 16.verticalSpace,
                            // TextInputField(
                            //   hint: 'Donation Number',
                            //   height: 60.h,
                            //   textController: controller.numController,
                            // ),
                            16.verticalSpace,
                            controller.isAdding ? LoaderWidget() : MainButton(text: 'ADD', onPressed: () {controller.addDonationRecord(context);}),
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
