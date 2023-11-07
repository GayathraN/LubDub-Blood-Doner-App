import 'package:bood_donate/ui/reusable/snackbar.dart';
import 'package:bood_donate/ui/screens/donor_flow/donor_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonorSignUpController extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  String? gender;
  String? bloodGroup;
  DateTime? dob;

  BloodGroup? character = BloodGroup.aPlus;

  bool isLoading = false;

  /// register donor user firebase auth
  registerUser(BuildContext context) async {
    if(validate()) {
      isLoading = true;
      notifyListeners();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(), password: pwdController.text.trim());
        await userCredential.user?.updateDisplayName(nameController.text)
            .whenComplete(() {
          FirebaseDatabase.instance.ref().child("Donors").child(
              userCredential.user!.uid).set({
            'name': nameController.text.trim(),
            'address': addressController.text.trim(),
            'nic': nicController.text.trim(),
            'dob': dob.toString(),
            'gender': gender,
            'contact': contactController.text.trim(),
            'blood_group': bloodGroup,
            'donate_count': 0,
            'last_donate': '',
            'user_id': userCredential.user!.uid
          });
          Navigator.popUntil(context, (route) => false);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DonorBottomNavBar()));
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
      notifyListeners();
    } else {
      showToast(context, 'Please fill all the fields');
    }
  }

  onSelectGender(String? value) {
    gender = value;
    notifyListeners();
  }

  onSelectDob(DateTime date) {
    dob = date;
    if(dob != null) {
      dobController.text = DateFormat('dd MMM yyyy').format(dob!);
    }
    notifyListeners();
  }

  onSelectBloodGroup(BloodGroup? value) {
    character = value;
    switch (value!) {
      case BloodGroup.aPlus:
        bloodGroup = 'A+';
        break;
      case BloodGroup.aMin:
        bloodGroup = 'A-';
        break;
      case BloodGroup.bPlus:
        bloodGroup = 'B+';
        break;
      case BloodGroup.bMin:
        bloodGroup = 'B-';
        break;
      case BloodGroup.ab:
        bloodGroup = 'AB';
        break;
      case BloodGroup.oPlus:
        bloodGroup = 'O+';
        break;
      case BloodGroup.oMin:
        bloodGroup = 'O-';
        break;
      default:
        bloodGroup = 'A+';
        break;
    }
    notifyListeners();
  }

  bool validate(){
    if(nameController.text.isEmpty || addressController.text.isEmpty ||
    nicController.text.isEmpty || pwdController.text.isEmpty ||
    dob == null || gender == null ||
    contactController.text.isEmpty || bloodGroup == null){
      return false;
    } else{
      return true;
    }
  }
}


enum BloodGroup { aPlus, aMin, bPlus, bMin, ab, oPlus, oMin }
