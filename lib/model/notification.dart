class MyNotification {
  String? name;
  String? reqDate;

  MyNotification();

  MyNotification.fromSnapshot(dynamic value)
      : name = value["bank_name"],
        reqDate = value["request_date"];
}
