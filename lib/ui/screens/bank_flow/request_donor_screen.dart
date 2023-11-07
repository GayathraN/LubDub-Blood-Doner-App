import 'package:bood_donate/controllers/bank_home_controller.dart';
import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/model/bank.dart';
import 'package:bood_donate/model/donor.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/ui/reusable/main_button.dart';
import 'package:bood_donate/ui/screens/common/sign_in_screen.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RequestDonorScreen extends StatelessWidget {

  final Donor donor;

  const RequestDonorScreen({super.key, required this.donor});

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
              child: SingleChildScrollView(
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
                          child: Text(donor.name ?? 'n/a',
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
                                Text('${(donor.dob == null || donor.dob == '') ? 'n/a' :
                                DateFormat('dd MMM yyyy').format(DateTime.parse(donor.dob!)) }',style: TextStyle(fontSize: 15.w,color: Colors.white),)
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
                                Text(donor.address ?? 'n/a',style: TextStyle(fontSize: 15.w,color: Colors.white),)
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
                                Text(donor.contact ?? 'n/a',style: TextStyle(fontSize: 15.w,color: Colors.white),)
                              ],
                            ), ),
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
                              Icon(Icons.phone,size: 28.w,color: Colors.grey,), //change the icon
                              20.horizontalSpace,
                              Text(donor.bloodGroup ?? 'n/a',style: TextStyle(fontSize: 15.w,color: Colors.white),)
                            ],
                          ), ),
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
                                Text(donor.gender ?? 'n/a',style: TextStyle(fontSize: 15.w,color: Colors.white),)
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
                                Icon(Icons.show_chart,size: 28.w,color: Colors.grey,),
                                20.horizontalSpace,
                                Text('Total Donations: ${donor.donateCount ?? 'n/a'}',style: TextStyle(fontSize: 15.w,color: Colors.white),)
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
                                Icon(Icons.calendar_today,size: 28.w,color: Colors.grey,),
                                20.horizontalSpace,
                                Text(' Last Donate: ${(donor.lastDonate == null || donor.lastDonate == '') ? 'No records' :
                                DateFormat('dd MMM yyyy').format(DateTime.parse(donor.lastDonate!)) }',style: TextStyle(fontSize: 15.w,color: Colors.white),)
                              ],
                            ) ),
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: context.watch<BankHomeController>().addingRequest ?
                          LoaderWidget(color:  Color(0xFF0F9D0C),)
                          : MainButton(
                            color: Color(0xFF0F9D0C),
                            text: 'Request to Donate',onPressed: () async {

                            final homeController =
                            Provider.of<BankHomeController>(context, listen: false);
                            homeController.addRequest(context,donor.userId!);
                          },),
                        )
                      ],
                    ),
                  ),
                ),
            ),

          ],
        ),
      ),
    );
  }
}
