import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/ui/reusable/alert_dailog_container.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _UpComingCampsScreenState();
}

class _UpComingCampsScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    final homeController = Provider.of<DonorHomeController>(context, listen: false);
    homeController.getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DonorHomeController>(
        builder: (context, controller, child) => Scaffold(
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
                  //   onPressed: () {
                  //
                  //   },
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
                          controller.getNotification();
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
                  'Notification',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.w),
                ),),),
            Expanded(
                child: controller.isNotificationLoading ? LoaderWidget() :
                controller.notificationList.isEmpty ? Center(child: Text('No Notification',style: TextStyle(color: Colors.white,),)) :
                ListView.builder(
                    itemCount: controller.notificationList.length,
                    padding: EdgeInsets.only(bottom: 50.h),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(16.w),topLeft:  Radius.circular(16.w)),
                          color: AppColors.foregroundColor,
                        ),
                        child:Text(
                          controller.notificationList[index].reqDate != null ? DateFormat('yyyy MMM dd').format(DateTime.parse(controller.notificationList[index].reqDate!))
                              : 'n/a',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.w),
                        ),
                        ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 16.w, right: 16.w,),
                            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(16.w),bottomLeft:  Radius.circular(16.w),bottomRight:  Radius.circular(16.w)),
                              color: AppColors.foregroundColor,
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.account_balance,size: 28.w,color: AppColors.textColor,),
                                16.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.notificationList[index].name ?? 'n/a',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.w),
                                    ),
                                    Text(
                                      'Requested to donate blood',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.w),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }))
          ],
        ),
      ),
    ),);
  }

  Widget alertItem(IconData icon,String text){
    return Container(
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
          color: AppColors.backgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28.w,
              color: Colors.grey,
            ),
            20.horizontalSpace,
            Text(
              text,
              style: TextStyle(
                  fontSize: 15.w, color: Colors.white),
            )
          ],
        ));
  }
}
