class CampHistory {
  String? location;
  String? date;
  String? name;
  String? contact;
  String? campName;

  CampHistory();

  CampHistory.fromSnapshot(dynamic value)
      : date = value["date"],
        name = value["bank_name"],
        contact = value["contact"],
        campName = value["camp_name"],
        location = value["location"];
}
