class Donor {
  String? name;
  int? donateCount;
  String? address;
  String? bloodGroup;
  String? contact;
  String? dob;
  String? lastDonate;
  String? gender;
  String? nic;
  String? userId;

  Donor(this.name);

  Donor.fromSnapshot(dynamic value)
      : name = value["name"],
        donateCount = value["donate_count"],
        address = value["address"],
        bloodGroup = value["blood_group"],
        dob = value["dob"],
        lastDonate = value["last_donate"],
        gender = value["gender"],
        contact = value["contact"],
        userId = value["user_id"],
        nic = value["nic"];
}
