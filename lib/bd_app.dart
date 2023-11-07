import 'package:bood_donate/controllers/bank_home_controller.dart';
import 'package:bood_donate/controllers/bank_signup_controller.dart';
import 'package:bood_donate/controllers/donor_signup_controller.dart';
import 'package:bood_donate/controllers/donor_home_controller.dart';
import 'package:bood_donate/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'ui/screens/common/splash_screen.dart';

class BloodDonateApp extends StatelessWidget {
  const BloodDonateApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<DonorSignUpController>(
                  create: (_) => DonorSignUpController()),
              ChangeNotifierProvider<DonorHomeController>(
                  create: (_) => DonorHomeController()),
              ChangeNotifierProvider<SignInController>(
                  create: (_) => SignInController()),
              ChangeNotifierProvider<BankHomeController>(
                  create: (_) => BankHomeController()),
              ChangeNotifierProvider<BankSignUpController>(
                  create: (_) => BankSignUpController())
            ],
            child: MaterialApp(
              title: 'Lub Dub',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
                useMaterial3: true,
              ),
              home: const SplashScreen(),
            ),
          );
        });
  }
}
