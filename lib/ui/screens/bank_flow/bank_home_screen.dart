import 'package:bood_donate/controllers/bank_home_controller.dart';
import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/ui/screens/bank_flow/bank_profile_screen.dart';
import 'package:bood_donate/ui/screens/donor_flow/donor_profile_screen.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class BankHomeScreen extends StatefulWidget {
  const BankHomeScreen({super.key});

  @override
  State<BankHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<BankHomeScreen> {
  @override
  void initState() {
    final homeController =
        Provider.of<BankHomeController>(context, listen: false);
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
                            screen: const BankProfileScreen(),
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
            Consumer<BankHomeController>(
              builder: (context, controller, child) => controller.isLoading
                  ? Expanded(child: LoaderWidget())
                  : Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 22.h, left: 16.w),
                            child: Text(controller.bank?.name ?? 'n/a',
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
                                      Text('${controller.bank?.campCount ?? 0}',
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
                          (controller.bank?.latestCamp == null || controller.bank?.latestCamp == '') ? SizedBox() : Container(
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
                                    Text('Latest Camp Date',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.w,
                                            fontWeight: FontWeight.w500)),
                                    Text('${(controller.bank?.latestCamp == null || controller.bank?.latestCamp == '') ? 'n/a' :
                                    DateFormat('dd MMM yyyy').format(DateTime.parse(controller.bank!.latestCamp!)) }',
                                        style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: 18.w,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${(controller.bank?.latestCamp == null || controller.bank?.latestCamp == '') ? 'n/a' :
                                    DateTime.parse(controller.bank!.latestCamp!).difference(DateTime.now()).inDays}',
                                        style: TextStyle(
                                            color: AppColors.textColor,
                                            fontSize: 18.w,
                                            fontWeight: FontWeight.w500)),
                                    Text('Days to event',
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
