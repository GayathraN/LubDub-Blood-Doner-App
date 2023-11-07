import 'package:bood_donate/controllers/bank_home_controller.dart';
import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BankDonationHistoryScreen extends StatefulWidget {
  const BankDonationHistoryScreen({super.key});

  @override
  State<BankDonationHistoryScreen> createState() => _DonationHistoryScreenState();
}

class _DonationHistoryScreenState extends State<BankDonationHistoryScreen> {

  @override
  void initState() {
    final homeController =
    Provider.of<BankHomeController>(context, listen: false);
    homeController.getDonationHistory();
    super.initState();
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(Icons.arrow_back),
                  //   color: Colors.white,
                  // ),
                  // 20.horizontalSpace,
                  Image.asset(
                    'assets/images/header_logo.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: IconButton(
                        onPressed: (){
                          context.read<BankHomeController>().getDonationHistory();
                        },
                        icon:  Icon(
                          Icons.refresh,size: 30.w,color: Colors.white,)),
                  )
                ],
              ),
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                    left: 16.w, right: 16.w, top: 22.h, bottom: 22.h),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                  color: AppColors.foregroundColor,
                ),
                child: Center(
                    child: Text(
                      'Donations History',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.w),
                    ))),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                  color: AppColors.foregroundColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          '#',
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.w),
                        ),
                      ),
                    ),
                    Expanded(
                      flex:3,
                      child: Text(
                        'Name',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.w),
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Text(
                        'Camp',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.w),
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Text(
                        'Place',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.w),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Consumer<BankHomeController>(
                builder: (context, controller, child) => controller.isDonationsLoading ? LoaderWidget() : controller.campHistoryList.isEmpty ?
                Center(child: Text('No donations',style: TextStyle(color: Colors.white,),))
                    : ListView.builder(
                    itemCount: controller.donationList.length,
                    itemBuilder: (context,index) {
                      return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                          padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.w),
                            color: AppColors.foregroundColor,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex:1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: Text(
                                    '${index+1}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.w),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:3,
                                child: Text(
                                  controller.donationList[index].name ?? 'n/a',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.w),
                                ),
                              ),
                              Expanded(
                                flex:2,
                                child: Text(
                                  controller.donationList[index].campName ?? 'n/a',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.w),
                                ),
                              ),
                              Expanded(
                                flex:2,
                                child: Text(
                                  controller.donationList[index].location ?? 'n/a',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.w),
                                ),
                              ),
                            ],
                          ));
                    }
                ),),
            )
          ],
        ),
      ),
    );
  }
}
