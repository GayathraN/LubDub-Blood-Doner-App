import 'package:bood_donate/ui/reusable/snackbar.dart';
import 'package:bood_donate/ui/screens/bank_flow/bank_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class BankSignUpController extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  bool isLoading = false;

  /// register blood bank user firebase auth
  registerUser(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    if(validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(), password: pwdController.text.trim());
        await userCredential.user?.updateDisplayName('blood-bank-admin')
            .whenComplete(() {
          FirebaseDatabase.instance.ref().child("BloodBanks").child(
              userCredential.user!.uid).set({
            'bank_id': idController.text.trim(),
            'name': nameController.text.trim(),
            'location': locationController.text.trim(),
            'contact': contactController.text.trim(),
            'camp_count':0,
            'latest_camp':'',
            'user_id': userCredential.user!.uid
          });
          Navigator.popUntil(context, (route) => false);
          Navigator.push(context, MaterialPageRoute(builder: (context) => BankBottomNavBar()));
        });
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        if (e.code == 'weak-password') {
          showToast(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showToast(context, 'The account already exists for that email.');
        }  else {
          showToast(context, '${e.message}');
        }
      } catch (e) {
        isLoading = false;
        showToast(context, e.toString());
      }
    } else {
      showToast(context, 'Please fill all the fields');
    }
    isLoading = false;
    notifyListeners();
  }

  // validate email
  bool validate(){
    if(nameController.text.isEmpty || locationController.text.isEmpty ||
        idController.text.isEmpty || pwdController.text.isEmpty ||
        contactController.text.isEmpty) {
      return false;
    }else if(validateEmail(emailController.text)){
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
}
