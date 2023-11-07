import 'package:bood_donate/model/camp_history.dart';
import 'package:bood_donate/model/donation_history.dart';
import 'package:bood_donate/model/donor.dart';
import 'package:bood_donate/model/notification.dart';
import 'package:bood_donate/ui/reusable/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/bank.dart';

class DonorHomeController extends ChangeNotifier {

  // for home data
  bool isLoading = false;
  String name = '';
  Donor? donor;

  // for add record
  TextEditingController locController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController numController = TextEditingController();
  DateTime? date;
  bool isAdding = false;

  // for donation history
  List<DonationHistory> historyList = [];
  bool isHistoryLoading = false;

  // for upcoming  camps
  List<CampHistory> campList = [];
  bool isCampsLoading = false;

  // for notifications
  List<MyNotification> notificationList = [];
  bool isNotificationLoading = false;

  // blood banks
  bool isBloodBanksLoading = false;
  List<Bank> bankList = [];

  Bank? selectedBank;
  List<CampHistory> selectedCampList = [];
  bool isDropDownCampsLoading = false;
  CampHistory? selectedCamp;
  String selectedDate = '';

  /// get home data from db
  getHomeData() async {
    isLoading = true;
    name = FirebaseAuth.instance.currentUser?.displayName ?? '';
    // photoUrl = FirebaseAuth.instance.currentUser?.photoURL ?? '';

    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('Donors')
        .child(FirebaseAuth.instance.currentUser!.uid);

    DatabaseEvent event = await dbRef.once();
    donor = Donor.fromSnapshot(event.snapshot.value);

    isLoading = false;
    notifyListeners();
  }

  onSelectDate(DateTime val) {
    date = val;
    if(date != null) {
      dateController.text = DateFormat('dd MMM yyyy').format(date!);
    }
    notifyListeners();
  }

  /// add donation record
  addDonationRecord(BuildContext context) async {
    try {
      isAdding = true;
      notifyListeners();
      await FirebaseDatabase.instance
          .ref()
          .child("Donations")
          .child(selectedBank!.userId!)
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(DateFormat('yyyyMMddHHmm').format(DateTime.parse(selectedDate)).toString())
          .set({
        'name': name,
        'camp_name': selectedCamp!.campName,
        'location': locController.text,
        'date': selectedDate.toString(),
        'number': numController.text
      }).whenComplete(() => FirebaseDatabase.instance
                  .ref()
                  .child("Donors")
                  .child(FirebaseAuth.instance.currentUser!.uid)
                  .update({
                'donate_count': (donor?.donateCount ?? 0) + 1,
                'last_donate': selectedDate.toString(),
              }));
      resetData();
      getHomeData();
      getHistory();
      isAdding = false;
      showToast(context, 'Redord added successfully',isSuccess: true);
    } on Exception catch (e) {
      isAdding = false;
      showToast(context,'Something went wrong');
      print(e);
    }
    isAdding = false;
    notifyListeners();
  }

  resetData(){
    locController.clear();
    numController.clear();
    dateController.clear();
    date = null;
    selectedDate = '';
    isAdding = false;
  }

  mainReset(){
    selectedBank = null;
    selectedCamp = null;
    resetData();
  }

  /// get all donation done by user
  getHistory() async {
    isHistoryLoading = true;
    historyList.clear();
    // notifyListeners();
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('Donations');

    DatabaseEvent event = await dbRef.once();
    Map<dynamic, dynamic>? map = event.snapshot.value as Map?;

    if (map != null) {
      map.forEach((key, value) {
        Map<dynamic, dynamic>? map2 = value as Map?;
        if(map2 != null) {
          map2.forEach((key, value) {
            if(key == FirebaseAuth.instance.currentUser!.uid) {
              Map<dynamic, dynamic>? map3 = value as Map?;
              if(map3 != null){
                map3.forEach((key, value) {
                  DonationHistory score = DonationHistory.fromSnapshot(value);
                  historyList.add(score);
                });
              }
            }
          });
        }
      });
    }
    isHistoryLoading = false;
    notifyListeners();
  }

  /// get upcoming camps
  getUpcomingCamps() async {
    isCampsLoading = true;
    // notifyListeners();
    campList.clear();
    try {
      final dbRef = FirebaseDatabase.instance
          .ref()
          .child('Camps');

      DatabaseEvent event = await dbRef.once();
      Map<dynamic, dynamic>? map = event.snapshot.value as Map?;

      if (map != null) {
        map.forEach((key, value) {
          Map<dynamic, dynamic>? map2 = value as Map?;
          if(map2 != null) {
            map2.forEach((key, value) {
              CampHistory camp = CampHistory.fromSnapshot(value);
              campList.add(camp);
            });
          }

        });
      }
    } on Exception catch (e) {
      print(e);
    }
    isCampsLoading = false;
    notifyListeners();
  }

  /// get all request done by bank to current user
  getNotification() async {
    isNotificationLoading = true;
    notificationList.clear();
    // notifyListeners();
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('Requests')
        .child(FirebaseAuth.instance.currentUser!.uid);

    DatabaseEvent event = await dbRef.once();
    Map<dynamic, dynamic>? map = event.snapshot.value as Map?;

    if (map != null) {
      map.forEach((key, value) {
        MyNotification score = MyNotification.fromSnapshot(value);
        notificationList.add(score);
      });
    }
    isNotificationLoading = false;
    notifyListeners();
  }

  /// get all blood banks for dropdown
  getBloodBanks() async {
    isBloodBanksLoading = true;
    bankList.clear();
    campList.clear();
    final dbRef = FirebaseDatabase.instance
        .ref()
        .child('BloodBanks');

    DatabaseEvent event = await dbRef.once();
    Map<dynamic, dynamic>? map = event.snapshot.value as Map?;

    if (map != null) {
      map.forEach((key, value) {
        Bank bank = Bank.fromSnapshot(value);
        bankList.add(bank);
      });
    }
    isBloodBanksLoading = false;
    notifyListeners();
  }

  // when select blood bank from dropdown
  onBankSelect(Bank? bank){
    selectedBank = bank;
    getCamps();
  }

  /// get camps related to selected blood bank
  getCamps() async {
    isDropDownCampsLoading = true;
    selectedCampList.clear();
    notifyListeners();
    try {
      final dbRef = FirebaseDatabase.instance
          .ref()
          .child('Camps').child(selectedBank!.userId!);
      
      DatabaseEvent event = await dbRef.once();
      Map<dynamic, dynamic>? map = event.snapshot.value as Map?;
      
      if (map != null) {
        map.forEach((key, value) {
          CampHistory camp = CampHistory.fromSnapshot(value);
          selectedCampList.add(camp);
        });
      }
    } on Exception catch (e) {
      print('failed $e');
    }
    isDropDownCampsLoading = false;
    notifyListeners();
  }

  onSelectCamp(CampHistory camp){
    selectedCamp = camp;
    locController.text = selectedCamp?.location ?? '';
    dateController.text = selectedCamp?.date != null ? DateFormat('dd MMM yyyy').format(DateTime.parse(selectedCamp!.date!)) : '';
    selectedDate = selectedCamp?.date ?? '';
  }

}
