import 'package:bood_donate/controllers/sign_in_controller.dart';
import 'package:bood_donate/ui/reusable/loader.dart';
import 'package:bood_donate/ui/reusable/main_button.dart';
import 'package:bood_donate/ui/reusable/text_button.dart';
import 'package:bood_donate/ui/reusable/text_input_field.dart';
import 'package:bood_donate/ui/screens/common/sign_type_selection_screen.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {

  final bool disableBack;

  const SignInScreen({super.key, this.disableBack = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInController>(
      builder: (context, controller, child) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16.h, left: 16.w),
                child: Row(
                  children: [
                    disableBack ? SizedBox() : IconButton(
                      onPressed: () {Navigator.pop(context);},
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    disableBack ? SizedBox() : 20.horizontalSpace,
                    Image.asset(
                      'assets/images/header_logo.png',
                      width: MediaQuery.of(context).size.width * 0.7,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextInputField(
                        hint: 'Email Address',
                        height: 60.h,
                        textController: controller.emailController
                      ),
                      20.verticalSpace,
                      TextInputField(
                        hint: 'Password',
                        isPwd: true,
                        height: 60.h,
                        textController: controller.pwdController,
                      ),
                      20.verticalSpace,
                      controller.isLoading ? LoaderWidget() : MainButton(text: 'Sign In',
                          onPressed: () {
                        controller.login(context);
                          }
                      ),
                      40.verticalSpace,
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(fontSize: 15.w, color: Colors.white),
                      ),
                      8.verticalSpace,
                      TextButtonWidget(
                        text: 'Sign Up',
                        // iconData: Icons.login,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpTypeScreen()));
                        }, color: AppColors.accentColor,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
