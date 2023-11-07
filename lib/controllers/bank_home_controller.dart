import 'package:bood_donate/model/bank.dart';
import 'package:bood_donate/model/camp_history.dart';
import 'package:bood_donate/model/donation_history.dart';
import 'package:bood_donate/model/donor.dart';
import 'package:bood_donate/ui/reusable/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class BankHomeController extends ChangeNotifier {
  // for home data
  bool isLoading = false;
  String? name = '';
  Bank? bank;

  // for add record
  TextEditingController locController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateTime? date;
  bool organizing = false;

  // for donation history
  List<CampHistory> campHistoryList = [];
  bool isHistoryLoading = false;

  // for donor list
  List<Donor> donorsList = [];
  bool isDonorsLoading = false;

  // for donations list
  List<DonationHistory> donationList = [];
  bool isDonationsLoading = false;

  bool addingRequest = false;

  /// get home data from db
  getHomeData() async {
    isLoading = true;
    // photoUrl = FirebaseAuth.instance.currentUser?.photoURL ?? '';

    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('BloodBanks')
        .child(FirebaseAuth.instance.currentUser!.uid);

    DatabaseEvent event = await dbRef.once();
    bank = Bank.fromSnapshot(event.snapshot.value);
    name = bank?.name;

    isLoading = false;
    notifyListeners();
  }

  /// add camp record to db
  organizeCamp(BuildContext context) async {
    if(date != null && locController.text.isNotEmpty && numController.text.isNotEmpty) {
      organizing = true;
      notifyListeners();
      try {
        await FirebaseDatabase.instance
            .ref()
            .child("Camps")
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child(DateFormat('yyyyMMddHHmm').format(date!).toString())
            .set({
          'bank_name': name,
          'camp_name': nameController.text,
          'location': locController.text,
          'date': date.toString(),
          'contact': numController.text
        }).whenComplete(() =>
            FirebaseDatabase.instance
                .ref()
                .child("BloodBanks")
                .child(FirebaseAuth.instance.currentUser!.uid)
                .update({
              'camp_count': (bank?.campCount ?? 0) + 1,
              'latest_camp': date.toString(),
            }));
        resetData();
        getHomeData();
        getCampHistory();
        showToast(context, 'Redord added successfully',isSuccess: true);
      } on Exception catch (e) {
        showToast(context, 'Something went wrong');
        print(e);
      }
      organizing = false;
      notifyListeners();
    } else {
      showToast(context, 'Please fill required data');
    }

  }

  resetData() {
    locController.clear();
    numController.clear();
    dateController.clear();
    nameController.clear();
    date = null;
  }

  onSelectDate(DateTime val) {
    date = val;
    if(date != null) {
      dateController.text = DateFormat('dd MMM yyyy').format(date!);
    }
    notifyListeners();
  }

  /// get camps history from db
  getCampHistory() async {
    isHistoryLoading = true;
    campHistoryList.clear();
    // notifyListeners();
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('Camps')
        .child(FirebaseAuth.instance.currentUser!.uid);

    DatabaseEvent event = await dbRef.once();
    Map<dynamic, dynamic>? map = event.snapshot.value as Map?;

    if (map != null) {
      map.forEach((key, value) {
        CampHistory score = CampHistory.fromSnapshot(value);
        campHistoryList.add(score);
      });
    }
    isHistoryLoading = false;
    notifyListeners();
  }

  /// get all registered user from db
  getRegisteredDonors() async {
    isDonorsLoading = true;
    donorsList.clear();
    // notifyListeners();
    final dbRef = FirebaseDatabase.instance.ref().child('Donors');

    DatabaseEvent event = await dbRef.once();
    Map<dynamic, dynamic>? map = event.snapshot.value as Map?;

    if (map != null) {
      map.forEach((key, value) {
        Donor donor = Donor.fromSnapshot(value);
        donorsList.add(donor);
      });
    }
    isDonorsLoading = false;
    notifyListeners();
  }

  /// add donation request to user
  addRequest(BuildContext context, String id) {
    addingRequest = true;
    notifyListeners();
    try {
      FirebaseDatabase.instance
          .ref()
          .child("Requests")
          .child(id)
          .child(DateFormat('yyyyMMddHHmm').format(DateTime.now()).toString())
          .set({
        'bank_name': bank?.name,
        'request_date':DateTime.now().toString(),
      });
      showToast(context, 'Requested to donate',isSuccess: true);
    } on Exception catch (e) {
      showToast(context, e.toString());
    }
    addingRequest = false;
    notifyListeners();
  }

  /// get all donations related to bank from db
  getDonationHistory() async {
    isDonationsLoading = true;
    donationList.clear();
    // notifyListeners();
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('Donations')
        .child(FirebaseAuth.instance.currentUser!.uid);

    DatabaseEvent event = await dbRef.once();
    Map<dynamic, dynamic>? map = event.snapshot.value as Map?;

    if (map != null) {
      map.forEach((key, value) {
        Map<dynamic, dynamic>? map2 = value as Map?;
        if(map2 != null){
          map2.forEach((key, value) {
            DonationHistory score = DonationHistory.fromSnapshot(value);
            donationList.add(score);
          });
        }
      });
    }
    isDonationsLoading = false;
    notifyListeners();
  }

}
