class Bank {
  String? name;
  String? location;
  String? contact;
  String? bankId;
  int? campCount;
  String? latestCamp;
  String? userId;

  Bank(this.name);

  Bank.fromSnapshot(dynamic value)
      : name = value["name"],
        location = value["location"],
        contact = value["contact"],
        bankId = value["bank_id"],
        campCount = value["camp_count"],
        userId = value["user_id"],
        latestCamp = value["latest_camp"];
}
