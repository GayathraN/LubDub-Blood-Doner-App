class DonationHistory {
  String? name;
  String? location;
  String? date;
  String? number;
  String? campName;

  DonationHistory(this.name);

  DonationHistory.fromSnapshot(dynamic value)
      : name = value["name"],
        location = value["location"],
        number = value["number"],
        campName = value["camp_name"],
        date = value["date"];
}
