import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bood_donate/ui/screens/bank_flow/bank_bottom_navbar.dart';
import 'package:bood_donate/ui/screens/common/intro_screen.dart';
import 'package:bood_donate/ui/screens/donor_flow/donor_bottom_navbar.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  late bool isSignedIn = false;
  bool isBloodBank = false;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        isSignedIn = false;
      } else {
        print('User is signed in!');
        isSignedIn = true;
        isBloodBank = user.displayName == 'blood-bank-admin';
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double widthScale = MediaQuery.of(context).size.width / 375;

      return AnimatedSplashScreen.withScreenFunction(
      splash: Column(
        children: [
          Image.asset(
              'assets/images/launcher_icon.png',
              width: 120*widthScale,
              height:120*widthScale
          ),
        ],
      ),
      splashIconSize: 120*widthScale,
      //nextScreen: isSignedIn ? const HomeScreen() : const LoginScreen(),
      backgroundColor: AppColors.backgroundColor,
      screenFunction: _getNextScreen,
      duration: 2500,
      //animationDuration: const Duration(milliseconds: 1000),
      splashTransition: SplashTransition.fadeTransition,
      //disableNavigation: disableNavigation,
    );
  }

  Future<Widget> _getNextScreen() async {
      if (isSignedIn) {

        return isBloodBank ? BankBottomNavBar() : DonorBottomNavBar();
      } else {
        return const IntroScreen();
      }
  }

}