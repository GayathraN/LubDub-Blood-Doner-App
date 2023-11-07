import 'package:bood_donate/controllers/bank_home_controller.dart';
import 'package:bood_donate/model/donor.dart';
import 'package:bood_donate/ui/reusable/alert_dailog_container.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/ui/screens/bank_flow/request_donor_screen.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class DonorsScreen extends StatefulWidget {
  const DonorsScreen({super.key});

  @override
  State<DonorsScreen> createState() => _DonorsScreenState();
}

class _DonorsScreenState extends State<DonorsScreen> {

  @override
  void initState() {
    final homeController =
    Provider.of<BankHomeController>(context, listen: false);
    homeController.getRegisteredDonors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child:  Consumer<BankHomeController>(
        builder: (context, controller, child) => Column(
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
                          context.read<BankHomeController>().getRegisteredDonors();
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
                      'Registered Donors',
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex:1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 18.w),
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
                        'Address',
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
                child: controller.isDonorsLoading ? LoaderWidget() : controller.donorsList.isEmpty ?
                      Center(child: Text('No Registered Donors',style: TextStyle(color: Colors.white,),))
                    : ListView.builder(
                    itemCount: controller.donorsList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
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
                                padding: EdgeInsets.only(left: 18.w),
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
                                controller.donorsList[index].name ?? 'n/a',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.w),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Text(
                                controller.donorsList[index].address ?? 'n/a',
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
                                  icon: Icon(Icons.more_vert),
                                  color:Colors.white,
                                  onPressed: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: RequestDonorScreen(donor: controller.donorsList[index]),
                                      withNavBar: false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.slideUp,
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
        ),)
      ),
    );
  }
}
