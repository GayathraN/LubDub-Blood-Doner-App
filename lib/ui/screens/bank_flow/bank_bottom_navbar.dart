import 'package:bood_donate/ui/screens/bank_flow/bank_home_screen.dart';
import 'package:bood_donate/ui/screens/bank_flow/camp_history_screen.dart';
import 'package:bood_donate/ui/screens/bank_flow/donation_history_screen.dart';
import 'package:bood_donate/ui/screens/bank_flow/donors_list_screen.dart';
import 'package:bood_donate/ui/screens/bank_flow/organize_camp_screen.dart';
import 'package:bood_donate/ui/screens/donor_flow/add_donation_screen.dart';
import 'package:bood_donate/ui/screens/donor_flow/donor_donation_history_screen.dart';
import 'package:bood_donate/ui/screens/donor_flow/upcoming_screen.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class BankBottomNavBar extends StatelessWidget {
  BankBottomNavBar({Key? key}) : super(key: key);

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      BankHomeScreen(),
      CampHistoryScreen(),
      OrganizeCampScreen(),
      BankDonationHistoryScreen(),
      DonorsScreen()
    ];
  }

  void changeTab(){
    _controller.jumpToTab(1);
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext con) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: AppColors.accentColor,
        inactiveColorPrimary: Colors.white.withOpacity(.6),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.store),
        title: ("Camps"),
        activeColorPrimary: AppColors.accentColor,
        inactiveColorPrimary: Colors.white.withOpacity(.6),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.add,color:Colors.white,),
        title: ("Organize"),
        activeColorPrimary:Color(0xFF0F9D0C),
        inactiveColorPrimary: Colors.white.withOpacity(.6),
        onPressed: (context){
          // todo
          PersistentNavBarNavigator.pushNewScreen(
            context ?? con,
            screen: const OrganizeCampScreen(),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.slideUp,
          );
        }
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history_rounded),
        title: ("History"),
        activeColorPrimary: AppColors.accentColor,
        inactiveColorPrimary: Colors.white.withOpacity(.6),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_add),
        title: ("Request"),
        activeColorPrimary: AppColors.accentColor,
        inactiveColorPrimary:Colors.white.withOpacity(.6),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: AppColors.foregroundColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r),topRight: Radius.circular(16.r)),
        colorBehindNavBar: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.accentColor.withOpacity(0.1),
            spreadRadius: 0.3,
            blurRadius: 18,
            offset: const Offset(1, -3), // changes position of shadow
          ),
        ]
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation:const  ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style16, // Choose the nav bar style with this property.
    );
  }
}
