import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/ui/reusable/alert_dailog_container.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpComingCampsScreen extends StatefulWidget {
  const UpComingCampsScreen({super.key});

  @override
  State<UpComingCampsScreen> createState() => _UpComingCampsScreenState();
}

class _UpComingCampsScreenState extends State<UpComingCampsScreen> {

  @override
  void initState() {
    final homeController = Provider.of<DonorHomeController>(context, listen: false);
    homeController.getUpcomingCamps();
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
                          controller.getUpcomingCamps();
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
                  'Upcoming Camps',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.w),
                ))),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.w),
                  color: AppColors.foregroundColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex:1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
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
                      flex:2,
                      child: Text(
                        'Date',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.w),
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Text(
                        'Location',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.w),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'More',
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.w),
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
                child: controller.isCampsLoading ? LoaderWidget() :
                controller.campList.isEmpty ? Center(child: Text('No Upcoming Camps',style: TextStyle(color: Colors.white,),)) :
                ListView.builder(
                    itemCount: controller.campList.length,
                    padding: EdgeInsets.only(bottom: 50.h),
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.w),
                          color: AppColors.foregroundColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
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
                              flex:2,
                              child: Text(
                                controller.campList[index].date != null ? DateFormat('yyyy MMM dd').format(DateTime.parse(controller.campList[index].date!))
                                    : 'n/a',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.w),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Text(
                                controller.campList[index].location ?? 'n/a',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.w),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height:30.w,
                                width:30.w,
                                child: IconButton(
                                  icon: Icon(Icons.info_outline),
                                  color:Colors.white,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (_) => AlertDialogContainer(
                                            title: 'Camp Details',
                                            alignment: Alignment.center,
                                            contentWidget: Container(
                                              color: AppColors.foregroundColor,
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: 16.h),
                                                      child: Text(controller.campList[index].campName ?? 'n/a',
                                                          style: TextStyle(
                                                              color: AppColors.textColor,
                                                              fontSize: 15.w,
                                                              fontWeight: FontWeight.w600)),
                                                    ),
                                                  ),
                                                  16.verticalSpace,
                                                  alertItem(Icons.account_balance,controller.campList[index].name ?? 'n/a'),
                                                  8.verticalSpace,
                                                  alertItem(Icons.pin_drop,controller.campList[index].location ?? 'n/a'),
                                                  8.verticalSpace,
                                                  alertItem(Icons.calendar_today,controller.campList[index].date != null ? DateFormat('yyyy MMM dd').format(DateTime.parse(controller.campList[index].date!)) : 'n/a'),
                                                  8.verticalSpace,
                                                  alertItem(Icons.phone,controller.campList[index].contact ?? 'n/a'),
                                                  32.verticalSpace
                                                ],
                                              ),
                                            ),
                                        ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
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
