class UserModel {
  String? uid;
  String? password;
  String? fullname;
  String? email;
  String? phone;
  String? gender;
  String? dob;
  String? age;
  String? profilepic;

  UserModel({
    this.uid,
    this.password,
    this.fullname,
    this.email,
    this.profilepic,
    this.phone,
    this.gender,
    this.dob,
    this.age,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    password = map["password"];
    fullname = map["fullname"];
    email = map["email"];
    profilepic = map["profilepic"];
    age = map["age"];
    phone = map["phone"];
    gender = map["gender"];
    dob = map["dob"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "password": password,
      "fullname": fullname,
      "email": email,
      "profilepic": profilepic,
      "dob": dob,
      "age": age,
      "gender": gender,
      "phone": phone,
    };
  }
}
