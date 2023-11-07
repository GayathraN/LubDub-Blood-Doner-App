import 'package:bood_donate/ui/reusable/snackbar.dart';
import 'package:bood_donate/ui/screens/bank_flow/bank_bottom_navbar.dart';
import 'package:bood_donate/ui/screens/donor_flow/donor_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  bool isLoading = false;

  /// single sign in for user used for both donor and bank
  login(BuildContext context) async {
    if(validate()) {
      isLoading = true;
      notifyListeners();
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: pwdController.text.trim())
            .then((value) {
              reset();
              Navigator.popUntil(context, (route) => false);
              if(value.user?.displayName == 'blood-bank-admin'){
                Navigator.push(context, MaterialPageRoute(builder: (context) => BankBottomNavBar()),);
              } else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => DonorBottomNavBar()),);
              }
              return value;
        });
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          showToast(context, "Invalid login credentials");
        } else {
          showToast(context, '${e.message}');
          print(e.code);
        }
      }
      notifyListeners();
    } else {
      showToast(context, "Please check your email pwd");
    }
    isLoading = false;
    notifyListeners();
  }

  bool validate() {
    if(emailController.text.isEmpty && pwdController.text.isEmpty){
      return false;
    } else if(validateEmail(emailController.text)){
      return false;
    } else {
      return true;
    }
  }

  // method for validate email
  bool validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp("$pattern");
    if (regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  reset(){
    emailController.clear();
    pwdController.clear();
  }

}
