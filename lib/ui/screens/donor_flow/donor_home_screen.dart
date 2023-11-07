import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/ui/screens/donor_flow/donor_profile_screen.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final homeController = Provider.of<DonorHomeController>(context, listen: false);
    homeController.getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/header_logo.png',
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: IconButton(
                        onPressed: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const DonorProfileScreen(),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.slideUp,
                          );
                        },
                        icon:  Icon(
                          Icons.account_circle,size: 36.w,color: Colors.white,)),
                  )
                ],
              ),
            ),
            Consumer<DonorHomeController>(
              builder: (context, controller, child) => controller.isLoading
                  ? Expanded(child: LoaderWidget())
                  : Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 22.h, left: 16.w),
                            child: Text(controller.donor?.name ?? 'n/a',
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 18.w,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 16.w,
                                      right: 8.w,
                                      top: 16.h,
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
                                      top: 16.h,
                                      bottom: 16.h),
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.w),
                                    color: AppColors.foregroundColor,
                                  ),
                                  child: Column(
                                    children: [
                                      Text('${controller.donor?.donateCount ?? 0}',
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
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                top: 16.h,
                                bottom: 16.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.w),
                              color: AppColors.foregroundColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Last Donation Date',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.w,
                                        fontWeight: FontWeight.w500)),
                                Text(
                                    '${(controller.donor?.lastDonate == null || controller.donor?.lastDonate == '') ? 'No records' :
                                    DateFormat('dd MMM yyyy').format(DateTime.parse(controller.donor!.lastDonate!)) }',
                                    style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 18.w,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          (controller.donor?.lastDonate == null || controller.donor?.lastDonate == '') ? SizedBox() : Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                top: 16.h,
                                bottom: 16.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.w),
                              color: AppColors.foregroundColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Next Donation Date',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.w,
                                            fontWeight: FontWeight.w500)),
                                    Text('${(controller.donor?.lastDonate == null || controller.donor?.lastDonate == '') ? 'n/a' :
                                    DateFormat('dd MMM yyyy').format(DateTime.parse(controller.donor!.lastDonate!).add(Duration(days: 120))) }',
                                        style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: 18.w,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${(controller.donor?.lastDonate == null || controller.donor?.lastDonate == '') ? 'n/a' :
                                    DateTime.parse(controller.donor!.lastDonate!).add(Duration(days: 120)).difference(DateTime.now()).inDays}',
                                        style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: 18.w,
                                            fontWeight: FontWeight.w500)),
                                    Text('Days More',
                                        style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: 18.w,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
